//
//  Comment.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

struct CommentCostant {
    static let Id = "id"
    static let PostId = "postId"
    static let Name = "name"
    static let Email = "email"
    static let Body = "body"
}

class Comment: NSObject {
    var id: Int!
    var postId: Int!
    var name: String?
    var email: String?
    var body: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict[CommentCostant.Id] as! Int
        self.postId = dict[CommentCostant.PostId] as! Int
        self.name = dict[CommentCostant.Name] as? String
        self.email = dict[CommentCostant.Email] as? String
        self.body = dict[CommentCostant.Body] as? String
    }

}
