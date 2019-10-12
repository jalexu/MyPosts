//
//  PostsApi.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation
import Moya

public enum PostsApi {
    
    case getPostOfData(id: Int)
    
}

extension PostsApi: TargetType {
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    public var path: String {
        switch self {
        case .getPostOfData:
            return "todos"
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPostOfData:
            return .get
        }
        
    }
    
    public var sampleData: Data {
        switch self {
        case .getPostOfData:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .getPostOfData:
            return .requestPlain
            //return .requestParameters(parameters:["id": id], encoding: URLEncoding.queryString)
        }
        
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getPostOfData(_):
            return [:]
        }
    }
    
    public var validationType: ValidationType {
        return .customCodes([200])
    }
    
    
}

