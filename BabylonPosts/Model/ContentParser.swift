//
//  ContentParser.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

struct ParsingConstants {
    //Shared
    static let Id = "id"
    static let Body = "body"
    static let Name = "name"
    static let Email = "email"
    
    //Post
    static let UserId = "userId"
    static let Title = "title"
    
    //Comment
    static let PostId = "postId"
    
    //User
    static let Username = "username"
}

class ContentParser: NSObject {
    
    func parsedPostsAsDictionary(data: Data) -> [Int:Post]? {
        var result : [Int:Post] = [:]
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
            
            for post in parsedData {
                var parsedPost: [String:Any] = [:]
                parsedPost[PostCostant.Id] = post[ParsingConstants.Id]
                parsedPost[PostCostant.UserId] = post[ParsingConstants.UserId]
                parsedPost[PostCostant.Title] = post[ParsingConstants.Title]
                parsedPost[PostCostant.Body] = post[ParsingConstants.Body]
                
                let tempPost = Post(dict: parsedPost)
                result[tempPost.id] = tempPost
            }
            
        } catch {
            return nil
        }
        return result
    }
    
    func parsedCommentsAsDictionary(data: Data) -> [Int:Comment]? {
        var result : [Int:Comment] = [:]
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
            
            for comment in parsedData {
                var parsedComment: [String:Any] = [:]
                parsedComment[CommentCostant.Id] = comment[ParsingConstants.Id]
                parsedComment[CommentCostant.PostId] = comment[ParsingConstants.PostId]
                parsedComment[CommentCostant.Name] = comment[ParsingConstants.Name]
                parsedComment[CommentCostant.Email] = comment[ParsingConstants.Email]
                parsedComment[CommentCostant.Body] = comment[ParsingConstants.Body]
                
                let tempComment = Comment(dict: comment)
                result[tempComment.id] = tempComment
            }
            
        } catch {
            return nil
        }
        return result
    }
    
    func parsedUsersAsDictionary(data: Data) -> [Int:User]? {
        var result : [Int:User] = [:]
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
            
            for user in parsedData {
                var parsedUser: [String:Any] = [:]
                parsedUser[UserCostant.Id] = user[ParsingConstants.Id]
                parsedUser[UserCostant.Name] = user[ParsingConstants.Name]
                parsedUser[UserCostant.Username] = user[ParsingConstants.Username]
                parsedUser[UserCostant.Email] = user[ParsingConstants.Email]
                
                let tempUser = User(dict: user)                
                result[tempUser.id] = tempUser
            }
            
        } catch {
            return nil
        }
        return result
    }

}
