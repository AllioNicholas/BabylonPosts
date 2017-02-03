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
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "")
        self.tableView.refreshControl?.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        //Allow post selection only when user data are available
        self.tableView.allowsSelection = false
        
        //Display possible offline content first
        downloadOffline()
        
        //Downolad new data anyway in order to handle new entries or updates
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
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                    self.tableView.allowsSelection = true
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "An error occurred while downloading posts", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    self.tableView.refreshControl?.endRefreshing()
                }))
                self.present(alert, animated: true, completion: nil)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func downloadOffline() {
        contentDispatcher.getOfflinePosts { (posts) in
            if let posts = posts {
                self.postsDict = posts
                
                self.contentDispatcher.getOfflineUsers { (users) in
                    if let users = users {
                        self.userDict = users
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.tableView.allowsSelection = true
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.postsDict.count > 0 {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
            return 1
        } else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
            noDataLabel.text = "No posts available"
            noDataLabel.textAlignment = .center
            self.tableView.backgroundView = noDataLabel
            self.tableView.separatorStyle = .none
            return 0
        }
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
