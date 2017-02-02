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

    override func viewDidLoad() {
        super.viewDidLoad()

        contentDispatcher.getComments { (comment) in
            print(comment)
        }
        
        contentDispatcher.getPosts { (post) in
            print(post)
        }
        
        contentDispatcher.getUsers { (user) in
            print(user)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
