//
//  Post.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation

struct Post: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
}
