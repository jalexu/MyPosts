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
    
    struct Input {
        
    }
    
    struct Output {
        var postsReceived = BehaviorRelay<[ResponseGetData]>(value: [])
        var isPostsReived = BehaviorRelay<Bool?>(value: nil)
        var messageError = BehaviorRelay<String?>(value: nil)
        
    }
    
    let input: Input
    let output: Output
    
    init() {
        input = Input()
        output = Output()
        self.postsBussinesLogic = PostsBussinesLogic(respository: PostsApiRepository())
        self.getData()
        
    }
    
    init(postBL: PostsBLBehavior) {
        input = Input()
        output = Output()
        self.postsBussinesLogic = postBL
        
    }
    
    func getData(){
        self.output.isPostsReived.accept(false)
        do{
            try self.postsBussinesLogic.getPostOfData(id: 1).asObservable().retry(1).subscribe(
                onNext:{ response in
                    self.output.postsReceived.accept(response)
                    self.output.isPostsReived.accept(true)
                    
            }, onError: { responseError in
                self.output.messageError.accept(Bundle.main.object(forInfoDictionaryKey: "APIERROR") as? String)
                
            }).disposed(by: disposedBag)
        } catch {
            self.output.messageError.accept("Error por Excepcion")
        }
    }
}

