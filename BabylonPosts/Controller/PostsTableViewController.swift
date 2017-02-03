//
//  PostsTableViewController.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 02/02/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    let contentDispatcher = ContentDispatcher()
    var postsDict: [Int:Post] = [:]
    var userDict: [Int:User] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosts()

    }
    
    func loadPosts() {
        contentDispatcher.getPosts { (postDict) in
            if let postDict = postDict {
                self.postsDict = postDict
                
                self.contentDispatcher.getComments({ (commentsDict) in
                    if let comments = commentsDict {
                        for (id, comment) in comments {
                            self.postsDict[id]?.comments?.append(comment)
                        }
                    }
                })
                
                self.contentDispatcher.getUsers({ (usersDict) in
                    if let users = usersDict {
                        self.userDict = users
                    }
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsDict.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell

        if let cell = cell, let post = self.postsDict[indexPath.row+1] {
            cell.configure(with: post)
            return cell
        }
        
        return PostTableViewCell()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailPost", let indexPath = self.tableView.indexPathForSelectedRow {
            let destination = segue.destination as! DetailPostViewController
            if let post = self.postsDict[indexPath.row+1], let author = self.userDict[post.userId] {
                destination.post = post
                destination.author = author
            }
        }
    }

}
