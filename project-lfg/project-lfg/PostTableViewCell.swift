//
//  PostTableViewCell.swift
//  project-lfg
//
//  Created by Thayamkery, George B on 4/24/18.
//  Copyright © 2018 Team Accord. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainingImage: UIView!
    @IBOutlet weak var myCellLabel: UILabel!
    @IBOutlet weak var filledInSpots: UILabel!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainingImage.layer.cornerRadius = 8
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.red.cgColor
        containerView.layer.shadowColor = UIColor.red.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 14)
        containerView.layer.shadowOpacity = 0.14
        containerView.layer.shadowRadius = 14
        containerView.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
