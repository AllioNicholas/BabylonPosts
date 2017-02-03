//
//  DetailPostViewController.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 03/02/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {
    var post: Post?
    var author: User?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var nameUsernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.titleLabel.text = post?.title ?? "-"
        self.bodyLabel.text = post?.body ?? "..."
        self.nameUsernameLabel.text = "\(author?.username ?? "") - \(author?.name ?? "")"
        self.emailLabel.text = author?.email ?? ""
    }

}

extension DetailPostViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if let comments = self.post?.comments, comments.count > 0 {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
            return 1
        } else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
            noDataLabel.text = "No comments available"
            noDataLabel.textAlignment = .center
            self.tableView.backgroundView = noDataLabel
            self.tableView.separatorStyle = .none
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let comments = self.post?.comments {
            return comments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentTableViewCell
        
        if let cell = cell, let comment = self.post?.comments?[indexPath.row] {
            cell.configure(with: comment)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let comments = self.post?.comments {
            return "Comments: \(comments.count)"
        } else {
            return nil
        }
    }
}

extension DetailPostViewController: UITableViewDelegate {
    
}
