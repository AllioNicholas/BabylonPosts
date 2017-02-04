//
//  FirebaseDispatcher.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 03/02/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseDispatcher: NSObject {
    fileprivate var firebasePostRef: FIRDatabaseReference!
    fileprivate var firebaseCommentRef: FIRDatabaseReference!
    fileprivate var firebaseUserRef: FIRDatabaseReference!
    
    fileprivate let contentParser = ContentParser()
    
    override init() {
        super.init()
        firebasePostRef = FIRDatabase.database().reference(withPath: "posts")
        firebaseCommentRef = FIRDatabase.database().reference(withPath: "comments")
        firebaseUserRef = FIRDatabase.database().reference(withPath: "users")
    }
    
    func getOfflinePosts(_ completion: @escaping ([Int:Post]?)->()) {
        self.firebasePostRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as! [[String:Any]]
            let offlineRes = self.contentParser.parsedPostsAsDictionary(arrOfDict: snapshotValue)
            
            if offlineRes.count > 0 {
                completion(offlineRes)
            } else {
                completion(nil)
            }
        })
    }
    
    func getOfflineComments(_ completion: @escaping ([Int:Comment]?)->()) {
        self.firebaseCommentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as! [[String:Any]]
            let offlineRes = self.contentParser.parsedCommentsAsDictionary(arrOfDict: snapshotValue)
            
            if offlineRes.count > 0{
                completion(offlineRes)
            } else {
                completion(nil)
            }
        })
    }
    
    func getOfflineUsers(_ completion: @escaping ([Int:User]?)->()) {
        self.firebaseUserRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as! [[String:Any]]
            let offlineRes = self.contentParser.parsedUsersAsDictionary(arrOfDict: snapshotValue)
            
            if offlineRes.count > 0 {
                completion(offlineRes)
            } else {
                completion(nil)
            }
        })
    }
    
    func sendPostsOffline(posts: [Int:Post]) {
        DispatchQueue.global(qos: .background).async {
            var postsObject: [[String:Any]] = []
            for (_, post) in posts {
                postsObject.append(post.toFirebaseObject())
            }
            self.firebasePostRef.setValue(postsObject)
        }
    }
    
    func sendCommentsOffline(comments: [Int:Comment]) {
        DispatchQueue.global(qos: .background).async {
            var commentsObject: [[String:Any]] = []
            for (_, comment) in comments {
                commentsObject.append(comment.toFirebaseObject())
            }
            self.firebaseCommentRef.setValue(commentsObject)
        }
    }
    
    func sendUsersOffline(users: [Int:User]) {
        DispatchQueue.global(qos: .background).async {
            var usersObject: [[String:Any]] = []
            for (_, user) in users {
                usersObject.append(user.toFirebaseObject())
            }
            self.firebaseUserRef.setValue(usersObject)
        }
    }

}
