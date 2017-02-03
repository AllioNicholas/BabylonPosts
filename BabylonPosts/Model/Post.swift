//
//  Post.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

struct PostCostant {
    static let Id = "id"
    static let UserId = "userId"
    static let Title = "title"
    static let Body = "body"
}

class Post: NSObject {
    var id: Int!
    var userId: Int!
    var title: String?
    var body: String?
    
    var comments: [Comment]?
    
    init(dict: [String:Any]) {
        super.init()
        self.id = dict[PostCostant.Id] as! Int
        self.userId = dict[PostCostant.UserId] as! Int
        self.title = dict[PostCostant.Title] as? String
        self.body = dict[PostCostant.Body] as? String
        self.comments = []
    }

}

extension Post {
    func toFirebaseObject() -> [String:Any] {
        return [PostCostant.Id: self.id,
                PostCostant.UserId: self.userId,
                PostCostant.Title: self.title ?? "",
                PostCostant.Body: self.body ?? ""
        ]
    }
}
