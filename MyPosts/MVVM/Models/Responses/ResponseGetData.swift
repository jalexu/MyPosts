
//
//  ResponseGetData.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation

class ResponseGetData: Codable{
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init(){}
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
