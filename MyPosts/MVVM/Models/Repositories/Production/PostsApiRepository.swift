//
//  PostsApiRepository.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import RxSwift

class PostsApiRepository: PostsApiRepositoryBehavior{
    
    let postsApi: MoyaProvider<PostsApi>! = MoyaProvider<PostsApi>()
    
    func getPostOfData(id: Int) throws -> Observable<[ResponseGetData]> {
        return postsApi.rx.request(PostsApi.getPostOfData(id: id)).asObservable().flatMap({ responseGetData -> Observable <[ResponseGetData]> in
            
            if responseGetData.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let resultResponseGetData = try decoder.decode([ResponseGetData].self, from: responseGetData.data)
                    return Observable.just(resultResponseGetData)
                }
            } else {
                let error = NSError(domain: "Error comunityApi", code: responseGetData.statusCode, userInfo: ["Error": responseGetData.statusCode.description])
                return Observable.error(error)
            }
            
        })
    }
}
