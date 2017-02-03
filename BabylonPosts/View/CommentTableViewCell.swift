//
//  CommentTableViewCell.swift
//  BabylonPosts
//
//  Created by Nicholas Allio on 03/02/2017.
//  Copyright © 2017 Nicholas Allio. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configure(with comment: Comment) {
        self.titleLabel.text = comment.name ?? "-"
        self.contentLabel.text = comment.body ?? "..."
    }

}
