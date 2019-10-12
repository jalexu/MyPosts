//
//  PostsApiRepositoryBehavior.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//
import Foundation
import RxSwift


protocol PostsApiRepositoryBehavior {
    func getPostOfData(id: Int) throws -> Observable<ResponseGetData>
}

