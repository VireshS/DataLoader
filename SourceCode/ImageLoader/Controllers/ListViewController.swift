//
//  ViewController.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    
    @IBOutlet weak var moviesTableView: UITableView!
    fileprivate var dataSource:[Movie] = [Movie]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.addTarget(self, action: #selector(self.onRefresh), for: .valueChanged)
        self.moviesTableView.refreshControl = self.refreshControl
        self.title = "Movies"
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        self.createAndAddProgressView()
        self.downloadMovies()
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
    
    @objc func onImageDownloaded(notification:Notification)
    {
        //If any image download is finished
        if let userInfo = notification.userInfo
        {
            if let imageKey = userInfo["image_key"] as? String
            {
                if let visibleCell = self.moviesTableView.visibleCells as? [ListItemTableViewCell]
                {
                    //Check if movie for same image is currently visible
                    for cell in visibleCell
                    {
                        if let validPosterUrl = cell.currentMovie?.Poster?.trim().lowercased()
                        {
                            if(validPosterUrl == imageKey.lowercased())
                            {
                                //If visible, reload the cell and now image will be updated directly from the ImageCache
                                if let validPath = self.moviesTableView.indexPath(for: cell)
                                {
                                    self.moviesTableView.reloadRows(at: [validPath], with: .none)
                                }
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ListViewController
{
    @objc func onRefresh()  {
        //On refresh, discard downloaded images and redownload them again
        ImageCache.discardCache()
        //also remove any other cache collected
        MovieDataService.defaultService().cleanup()
        //Download the data again
        self.downloadMovies()
    }
    
    func downloadMovies()
    {
        MovieDataService.defaultService().allMovies { [weak self](movies, error) in
            if let strongSelf = self
             {
                strongSelf.refreshControl.endRefreshing()
                if(error != nil)
                {
                    strongSelf.showAlert(with: error!.displayableErrorMessage())
                }
                else if(movies != nil)
                {
                    strongSelf.dataSource.append(contentsOf: movies!)
                    strongSelf.moviesTableView.reloadData()
                }
            }
        }
    }
    
    private func showAlert(with error:String)
    {
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListViewController:UITableViewDelegate, UITableViewDataSource
{
    func createAndAddProgressView() {
        if(self.moviesTableView.backgroundView == nil)
        {
            let bgView = UIView(frame: self.moviesTableView.bounds)
            let label = UILabel(frame: CGRect(x: 15, y: (view.bounds.size.height - 20)/2, width: view.bounds.size.width - 30, height: 20))
            label.text = "Loading, please wait..."
            bgView.addSubview(label)
            label.center = bgView.center
            label.textAlignment = .center
            self.moviesTableView.backgroundView = bgView
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "ListItemTableViewCell", for: indexPath) as? ListItemTableViewCell
        {
            let movieToList = self.dataSource[indexPath.row]
            cell.currentMovie = movieToList
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedMovieCell = tableView.cellForRow(at: indexPath) as? ListItemTableViewCell
        {
            if let selectedMovie = selectedMovieCell.currentMovie
            {
                if let destination = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
                {
                    destination.currentMovie = selectedMovie
                    self.navigationController?.pushViewController(destination, animated: true)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

