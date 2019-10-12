//
//  PostsBussinesLogic.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation
import RxSwift

class PostsBussinesLogic: PostsBLBehavior {
    
    var postsRepository: PostsApiRepositoryBehavior
    
    init(respository: PostsApiRepositoryBehavior) {
        self.postsRepository = respository
    }
    
    func getPostOfData(id: Int) throws -> Observable<[ResponseGetData]> {
        return try postsRepository.getPostOfData(id: id).asObservable().flatMap({ response -> Observable<[ResponseGetData]> in
            return Observable.just(response)
        })
    }
    
    
}
