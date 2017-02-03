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
    fileprivate let firebasePostRef = FIRDatabase.database().reference(withPath: "posts")
    fileprivate let firebaseUserRef = FIRDatabase.database().reference(withPath: "users")
    
    fileprivate let contentParser = ContentParser()
    
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
        
    }
    
    func sendUsersOffline(posts: [Int:User]) {
        
    }

}
