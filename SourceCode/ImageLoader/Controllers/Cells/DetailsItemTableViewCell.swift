//
//  ListItemTableViewCell.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit

class DetailsItemTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviewSubTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.moviewSubTitleLabel.numberOfLines = 0
        
        //Required For Automated UI Testing
        self.movieTitleLabel.isAccessibilityElement = true
        self.movieTitleLabel.accessibilityIdentifier = "movie_item_title"
        self.moviewSubTitleLabel.isAccessibilityElement = true
        self.moviewSubTitleLabel.accessibilityIdentifier = "movie_item_subtitle"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
