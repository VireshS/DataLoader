//
//  ListItemTableViewCell.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageContainerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieImageView?.clipsToBounds = true
        self.movieImageContainerView?.clipsToBounds = true
        
        self.movieImageView?.layer.masksToBounds = true
        self.movieImageContainerView?.layer.masksToBounds = true
        
        //Required For Automated UI Testing
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = "movie_cell"
        self.movieTitleLabel.isAccessibilityElement = true
        self.movieTitleLabel.accessibilityIdentifier = "movie_title"
        self.movieImageView.isAccessibilityElement = true
        self.movieImageView.accessibilityIdentifier = "movie_image"
    }
    
    var currentMovie:Movie? = nil
    {
        didSet
        {
            self.activityIndicator.stopAnimating()
            if let unwrappedMovie = self.currentMovie
            {
                //If given Movie object is not nil
                if let movieImage = MovieDataService.defaultService().image(forMovie: unwrappedMovie)
                {
                    //Image is already downlaoded and cached
                    self.movieImageView?.image = movieImage
                }
                else if(MovieDataService.defaultService().isDownloadingPoster(forMovie: unwrappedMovie))
                {
                    //Image is not yet downloaded but is in progress
                    self.movieImageView?.image = UIImage(named: "Downloading")
                    self.activityIndicator.startAnimating()
                    self.movieImageContainerView.bringSubviewToFront(self.activityIndicator)
                }
                else
                {
                    //Image neither downloaded, nor in progress, hence no image
                    self.movieImageView?.image = UIImage(named: "NoImage")
                }
            }
            else
            {
               self.movieImageView?.image = UIImage(named: "NoImage")
            }
            
            if let title = self.currentMovie?.Title, title.count>0
            {
                self.movieTitleLabel.text = title
            }
            else
            {
                self.movieTitleLabel.text = "Movie Title Not Available."
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.currentMovie = nil
        self.activityIndicator.stopAnimating()
    }
}
