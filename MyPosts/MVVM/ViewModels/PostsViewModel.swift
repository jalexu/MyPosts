//
//  PostsViewModel.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class PostsViewModel: ViewModelProtocol {
    
    private let disposedBag = DisposeBag()
    private var postsBussinesLogic: PostsBLBehavior
    private var persistenceManager = PersistenceManager.shared
    
    struct Input {
        
    }
    
    struct Output {
        var postsReceived = BehaviorRelay<[ResponseGetData]>(value: [])
        var postsFromCoreData = BehaviorRelay<[Post]>(value: [])
        var isPostsRecived = BehaviorRelay<Bool?>(value: nil)
        var messageError = BehaviorRelay<String?>(value: nil)
        
    }
    
    let input: Input
    let output: Output
    
    init() {
        input = Input()
        output = Output()
        self.postsBussinesLogic = PostsBussinesLogic(respository: PostsApiRepository())
        self.getPostsFromApi()
        
    }
    
    init(postBL: PostsBLBehavior) {
        input = Input()
        output = Output()
        self.postsBussinesLogic = postBL
        
    }
    
    func getData(){
        self.output.isPostsRecived.accept(false)
        do{
            try self.postsBussinesLogic.getPostOfData(id: 1).asObservable().retry(1).subscribe(
                onNext:{ response in
                    self.output.postsReceived.accept(response)
                    self.createPost()
                    
            }, onError: { responseError in
                self.output.messageError.accept(Bundle.main.object(forInfoDictionaryKey: "APIERROR") as? String)
                
            }).disposed(by: disposedBag)
        } catch {
            self.output.messageError.accept("Error por Excepcion")
        }
    }
    
    
    //create core data 
    private func createPost(){
        
        for posts in self.output.postsReceived.value {
            let post = Post(context: persistenceManager.context)
            post.userId = Int16 (posts.userId!)
            post.id = Int16 (posts.id!)
            post.title = posts.title
            post.body = posts.body
            post.read = false
            post.favorite = false
            persistenceManager.saveContext()
            
        }
        let posts = persistenceManager.fetch(Post.self)
        self.output.postsFromCoreData.accept(posts)
        self.output.isPostsRecived.accept(true)
    }
    
    func getPostsFromApi(){
        let posts = persistenceManager.fetch(Post.self)
        
        if posts.count == 0{
            self.getData()
        }else{
            self.output.postsFromCoreData.accept(posts)
            self.output.isPostsRecived.accept(true)
        }
    }
    

}

