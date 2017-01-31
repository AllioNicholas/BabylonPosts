//
//  ContentDispatcher.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 31/01/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ContentDispatcher: NSObject {
    
    fileprivate let session = URLSession.shared
    fileprivate let parser = ContentParser()
    
    fileprivate let baseURLString = "http://jsonplaceholder.typicode.com/"
    fileprivate let postsSuffix = "posts"
    fileprivate let commentsSuffix = "comments"
    fileprivate let usersSuffix = "users"
    
    func getPosts(_ completionHandler: @escaping ([Post]?)->()) {
        let callURLString = baseURLString + postsSuffix
        let callURL = URL(string: callURLString)
        
        if let url = callURL {
            getData(fromURL: url, { (data) in
                if let dataToParse = data, let posts = self.parser.parsedPosts(data: dataToParse) {
                    completionHandler(posts)
                } else {
                    completionHandler(nil)
                }
            })
        } else {
            completionHandler(nil)
        }
    }
    
    func getComments(_ completionHandler: @escaping ([Comment]?)->()) {
        let callURLString = baseURLString + commentsSuffix
        let callURL = URL(string: callURLString)
        
        if let url = callURL {
            getData(fromURL: url, { (data) in
                if let dataToParse = data, let comments = self.parser.parsedComments(data: dataToParse) {
                    completionHandler(comments)
                } else {
                    completionHandler(nil)
                }
            })
        } else {
            completionHandler(nil)
        }
    }
    
    func getUsers(_ completionHandler: @escaping ([User]?)->()) {
        let callURLString = baseURLString + usersSuffix
        let callURL = URL(string: callURLString)
        
        if let url = callURL {
            getData(fromURL: url, { (data) in
                if let dataToParse = data, let users = self.parser.parsedUsers(data: dataToParse) {
                    completionHandler(users)
                } else {
                    completionHandler(nil)
                }
            })
        } else {
            completionHandler(nil)
        }
    }
    
    func getData(fromURL: URL, _ completion: @escaping (Data?)->()) {
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
