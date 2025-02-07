//
//  ContentDispatcher.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

class ContentDispatcher: NSObject {
    
    fileprivate let session = URLSession.shared
    fileprivate let parser = ContentParser()
    fileprivate let firebaseDispatcher = FirebaseDispatcher()
    
    fileprivate let baseURLString = "http://jsonplaceholder.typicode.com/"
    fileprivate let postsSuffix = "posts"
    fileprivate let commentsSuffix = "comments"
    fileprivate let usersSuffix = "users"
    
    // MARK: - Offline data
    
    func getOfflinePosts(_ completion: @escaping ([Int:Post]?)->()) {
        firebaseDispatcher.getOfflinePosts { (posts) in
            if let posts = posts {
                completion(posts)
            } else {
                completion(nil)
            }
        }
    }
    
    func getOfflineComments(_ completion: @escaping ([Int:Comment]?)->()) {
        firebaseDispatcher.getOfflineComments { (comments) in
            if let comments = comments {
                completion(comments)
            } else {
                completion(nil)
            }
        }
    }
    
    func getOfflineUsers(_ completion: @escaping ([Int:User]?)->()) {
        firebaseDispatcher.getOfflineUsers { (users) in
            if let users = users {
                completion(users)
            } else {
                completion(nil)
            }
        }
    }
    
    func sendOffline(posts: [Int:Post]) {
        firebaseDispatcher.sendPostsOffline(posts: posts)
    }
    
    func sendOffline(comments: [Int:Comment]) {
        firebaseDispatcher.sendCommentsOffline(comments: comments)
    }
    
    func sendOffline(users: [Int:User]) {
        firebaseDispatcher.sendUsersOffline(users: users)
    }
    
    // MARK: - Online data
    
    func getPosts(_ completionHandler: @escaping ([Int:Post]?)->()) {
        let callURLString = baseURLString + postsSuffix
        let callURL = URL(string: callURLString)
        
        if let url = callURL {
            getData(fromURL: url, { (data) in
                if let dataToParse = data, let posts = self.parser.parsedPostsAsDictionary(data: dataToParse) {
                    completionHandler(posts)
                } else {
                    completionHandler(nil)
                }
            })
        } else {
            completionHandler(nil)
        }
    }
    
    func getComments(_ completionHandler: @escaping ([Int:Comment]?)->()) {
        let callURLString = baseURLString + commentsSuffix
        let callURL = URL(string: callURLString)
        
        if let url = callURL {
            getData(fromURL: url, { (data) in
                if let dataToParse = data, let comments = self.parser.parsedCommentsAsDictionary(data: dataToParse) {
                    completionHandler(comments)
                } else {
                    completionHandler(nil)
                }
            })
        } else {
            completionHandler(nil)
        }
    }
    
    func getUsers(_ completionHandler: @escaping ([Int:User]?)->()) {
        let callURLString = baseURLString + usersSuffix
        let callURL = URL(string: callURLString)
        
        if let url = callURL {
            getData(fromURL: url, { (data) in
                if let dataToParse = data, let users = self.parser.parsedUsersAsDictionary(data: dataToParse) {
                    completionHandler(users)
                } else {
                    completionHandler(nil)
                }
            })
        } else {
            completionHandler(nil)
        }
    }
    
    fileprivate func getData(fromURL: URL, _ completion: @escaping (Data?)->()) {
        let request = URLRequest(url: fromURL)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard (error == nil) else {
                completion(nil)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            completion(data)
        }
        
        task.resume()
    }

}
