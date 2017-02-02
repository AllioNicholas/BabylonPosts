//
//  User.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

struct UserCostant {
    static let Id = "id"
    static let Name = "name"
    static let Username = "username"
    static let Email = "email"
}

class User: NSObject {
    var id: Int!
    var name: String?
    var username: String?
    var email: String?
    
    init(dict: [String:AnyObject]) {
        super.init()
        self.id = dict[UserCostant.Id] as! Int
        self.name = dict[UserCostant.Name] as? String
        self.username = dict[UserCostant.Username] as? String
        self.email = dict[UserCostant.Email] as? String
    }

}
