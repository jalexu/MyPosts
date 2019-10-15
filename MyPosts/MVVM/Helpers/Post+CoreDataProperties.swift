//
//  Post+CoreDataProperties.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/14/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var read: Bool
    @NSManaged public var body: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var userId: Int16
    
}
