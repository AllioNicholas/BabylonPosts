//
//  ContentParser.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

struct ParsingConstants {
    //Post
    static let id = "id"
    static let userId = "userId"
    static let title = "title"
    static let body = "body"
    
    //Comment
    
    //User
}

class ContentParser: NSObject {
    
    func parsedPosts(data: Data) -> [Post]? {
        var result : [Post] = []
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:AnyObject]]
            
            for post in parsedData {
                let tempPost = Post()
                tempPost.id = post[ParsingConstants.id] as! Int
                tempPost.userId = post[ParsingConstants.userId] as! Int
                tempPost.title = post[ParsingConstants.title] as? String
                tempPost.body = post[ParsingConstants.body] as? String
                
                result.append(tempPost)
            }
            
        } catch {
            return nil
        }
        return result
    }
    
    func parsedComments(data: Data) -> [Comment]? {
        var result : [Comment] = []
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:AnyObject]]
            
            for comment in parsedData {
                let tempComment = Comment()
                
                
                result.append(tempComment)
            }
            
        } catch {
            return nil
        }
        return result
    }
    
    func parsedUsers(data: Data) -> [User]? {
        var result : [User] = []
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:AnyObject]]
            
            for user in parsedData {
                let tempUser = User()
                
                result.append(tempUser)
            }
            
        } catch {
            return nil
        }
        return result
    }

}
