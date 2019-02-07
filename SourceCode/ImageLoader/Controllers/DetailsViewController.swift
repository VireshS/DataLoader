//
//  ViewController.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieDetailsTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var currentMovie:Movie? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.clipsToBounds = true
        self.imageView.layer.masksToBounds = true
        self.movieDetailsTableView.delegate = self
        self.movieDetailsTableView.dataSource = self
        self.titleLabel.layer.shadowColor = UIColor.black.cgColor
        self.titleLabel.layer.shadowRadius = 1.0
        self.titleLabel.layer.shadowOpacity = 0.8
        self.titleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.titleLabel.layer.masksToBounds = false
        
        self.subTitleLabel.layer.shadowColor = UIColor.black.cgColor
        self.subTitleLabel.layer.shadowRadius = 1.0
        self.subTitleLabel.layer.shadowOpacity = 0.8
        self.subTitleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.subTitleLabel.layer.masksToBounds = false
        self.updateData()
        
        //Required For Automated UI Testing
        self.titleLabel.isAccessibilityElement = true
        self.titleLabel.accessibilityIdentifier = "movie_title"
        self.subTitleLabel.isAccessibilityElement = true
        self.subTitleLabel.accessibilityIdentifier = "movie_subtitle"
        self.imageView.isAccessibilityElement = true
        self.imageView.accessibilityIdentifier = "movie_image"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Subscripe for the image downloader notification which willl be broadcasted whenever a image is downloaded
        //So that UI can be refreshed
        NotificationCenter.default.addObserver(self,selector: #selector(self.onImageDownloaded(notification:)),
                                               name: Constants.ImageDownloadCompletionNotificationName,object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateData() {
        self.activityIndicator.stopAnimating()
        if let unwrappedMovie = self.currentMovie
        {
            self.title = unwrappedMovie.Title
            self.updateImage()
            self.titleLabel.text = unwrappedMovie.Title
            self.subTitleLabel.text = "Director: \(unwrappedMovie.Director ?? "Info Not Available")"
        }
    }
    
    func updateImage()
    {
        if let unwrappedMovie = self.currentMovie
        {
            if let movieImage = MovieDataService.defaultService().image(forMovie: unwrappedMovie)
            {
                //Image is already downlaoded and cached
                self.imageView?.image = movieImage
            }
            else if(MovieDataService.defaultService().isDownloadingPoster(forMovie: unwrappedMovie))
            {
                //Image is not yet downloaded but is in progress
                self.imageView?.image = UIImage(named: "Downloading")
                self.activityIndicator.startAnimating()
            }
            else
            {
                //Image neither downloaded, nor in progress, hence no image
                self.imageView?.image = UIImage(named: "NoImage")
            }
        }
        else
        {
            self.imageView?.image = UIImage(named: "NoImage")
        }
    }
    

    //When there is some image is downloaded
    @objc func onImageDownloaded(notification:Notification)
    {
        //If any image download is finished
        if let userInfo = notification.userInfo
        {
            if let imageKey = userInfo["image_key"] as? String
            {
                if let unwrappedMovie = self.currentMovie
                {
                    if let validPosterUrl = unwrappedMovie.Poster?.trim().lowercased()
                    {
                        if(validPosterUrl == imageKey.lowercased())
                        {
                            //If its the same image for which currently showing the details
                            self.updateImage()
                        }
                    }
                }
            }
        }
    }
}

extension DetailsViewController:UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "DetailsItemTableViewCell", for: indexPath) as? DetailsItemTableViewCell
        {
            switch(indexPath.row)
            {
                case 0:
                    cell.movieTitleLabel.text = "Genre"
                    cell.moviewSubTitleLabel.text = self.currentMovie?.Genre ?? "Not Available"
                break
            case 1:
                cell.movieTitleLabel.text = "Rating"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Ratings ?? "Not Available"
                break
            case 2:
                cell.movieTitleLabel.text = "Duration"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Runtime ?? "Not Available"
                break
            case 3:
                cell.movieTitleLabel.text = "Writer"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Writer ?? "Not Available"
                break
            case 4:
                cell.movieTitleLabel.text = "Actors"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Actors ?? "Not Available"
                break
            case 5:
                cell.movieTitleLabel.text = "Language"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Language ?? "Not Available"
                break
            case 6:
                cell.movieTitleLabel.text = "Awards"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Awards ?? "Not Available"
                break
            case 7:
                cell.movieTitleLabel.text = "Production"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Production ?? "Not Available"
                break
            case 8:
                cell.movieTitleLabel.text = "Plot"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Plot ?? "Not Available"
                break
            case 9:
                cell.movieTitleLabel.text = "Rated"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Rated ?? "Not Available"
                break
            case 10:
                cell.movieTitleLabel.text = "Released"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Released ?? "Not Available"
                break
            case 11:
                cell.movieTitleLabel.text = "Year"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Year ?? "Not Available"
                break
            case 12:
                cell.movieTitleLabel.text = "Country"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Country ?? "Not Available"
                break
            case 13:
                cell.movieTitleLabel.text = "Metascore"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Metascore ?? "Not Available"
                break
            case 14:
                cell.movieTitleLabel.text = "ImdbRating"
                cell.moviewSubTitleLabel.text = self.currentMovie?.ImdbRating ?? "Not Available"
                break
            case 15:
                cell.movieTitleLabel.text = "ImdbVotes"
                cell.moviewSubTitleLabel.text = self.currentMovie?.ImdbVotes ?? "Not Available"
                break
            case 16:
                cell.movieTitleLabel.text = "ImdbID"
                cell.moviewSubTitleLabel.text = self.currentMovie?.ImdbID ?? "Not Available"
                break
            case 17:
                cell.movieTitleLabel.text = "DVD"
                cell.moviewSubTitleLabel.text = self.currentMovie?.DVD ?? "Not Available"
                break
            case 18:
                cell.movieTitleLabel.text = "BoxOffice"
                cell.moviewSubTitleLabel.text = self.currentMovie?.BoxOffice ?? "Not Available"
                break
            case 19:
                cell.movieTitleLabel.text = "Website"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Website ?? "Not Available"
                break
            case 20:
                cell.movieTitleLabel.text = "Response"
                cell.moviewSubTitleLabel.text = self.currentMovie?.Response ?? "Not Available"
                break
            default:
                break
            }
            cell.accessoryType = .none
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 8)
        {
            return UITableView.automaticDimension;
        }
        return 60
    }
}
