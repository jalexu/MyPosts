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
    
    let disposedBag = DisposeBag()
    var postsBussinesLogic: PostsBLBehavior
    
    struct Output {
        
    }
    
    struct Input {
        
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
        
        do{
            try self.postsBussinesLogic.getPostOfData(id: 1).asObservable().retry(1).subscribe(
                onNext:{ response in
                    print(response)
                    
            }, onError: { responseError in
                print(responseError)
                
            }).disposed(by: disposedBag)
        } catch {
            
        }
    }
}

