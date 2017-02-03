//
//  PostTableViewCell.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 03/02/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    
    func configure(with post: Post) {
        self.titleLabel.text = post.title ?? "-"
        self.previewLabel.text = post.body ?? "..."
    }
}
