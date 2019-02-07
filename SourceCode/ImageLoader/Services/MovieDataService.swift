//
//  MovieDataService.swift
//  ImageLoader
//
//  Created by Viresh Singh on 07/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import Foundation
import UIKit
class MovieDataService
{
    var isMovieDownloadingInProgress = false
    var imageDownloadInProgress:Set<String> = Set<String>()
    private var failedURLs:[String] = [String]()
    static let sharedInstance = MovieDataService()
    class func defaultService() -> MovieDataService
    {
        return MovieDataService.sharedInstance
    }
    
    /// Download all the movies list
    func allMovies(withCompletionBlock:@escaping DataDownloader.movieListDownloadedBlock)
    {
        if(self.isMovieDownloadingInProgress)
        {
            //if already downloading, ignore
            return
        }
        self.isMovieDownloadingInProgress = true
        //create downloader operation
        let imageDownloadOperation = DataDownloader(withImageListUrl: Constants.movieListUrl) { (movies, error) in
            self.isMovieDownloadingInProgress = false
            withCompletionBlock(movies,error)
        }
        //add it to opeartion queue to download
        NetworkOperationsQueue.defaultQueue().setMaximumAllowedOperations(maximumOperations: 4)
        NetworkOperationsQueue.defaultQueue().addOperation(operation: imageDownloadOperation, withPriority: .Default)
    }
    
    ///Returns the image for given movie from Image Cache. If not available in caches, queues the request for download
    func image(forMovie movie:Movie, requiresOnPriority:Bool = false) -> UIImage?
    {
        //Check if poster URL is there
        if let posterURL = movie.Poster
        {
            let validUrlString = posterURL.trim()
            let validURL = URL(string: validUrlString)
            if(validURL?.scheme == nil || validURL?.host == nil)
            {
                //Its not a valid URL to download
                return nil
            }
            //Check if this image is already downloaded and is available in cache
            if let existingCachedImage = ImageCache.image(forKey: validUrlString)
            {
                //If so, just return it
                return existingCachedImage
            }
            else
            {
                //Image was not found in cache
                self.downloadAndCacheImage(for: validUrlString, withPriority: requiresOnPriority ? ImageDownloadingPriority.Immediate : ImageDownloadingPriority.Default)
            }
        }
        return nil
    }
    
    private func downloadAndCacheImage(for imageUrl:String, withPriority:ImageDownloadingPriority)
    {
        //As this image is not there in cache, lets download it
        if(self.imageDownloadInProgress.contains(imageUrl.lowercased()))
        {
            //Image download is already in progress
            return
        }
        if(self.failedURLs.contains(imageUrl.lowercased()))
        {
            //Image download already failed, do not retry unless refresh
            return
        }
        self.imageDownloadInProgress.insert(imageUrl.lowercased())
        //Invoke Image download operation
        let imageDownloadOperation = DataDownloader(withImageUrl: imageUrl) { (image, error) in
            if let unwrappedImage = image
            {
                //Successfully downloaded. lets cache it for further requests
                ImageCache.cache(image: unwrappedImage, forKey: imageUrl)
            }
            else
            {
                if(error != nil && error?.isNetworkError() == false)
                {
                    //If its failed not because of network error, do not try to redownload again
                    self.failedURLs.append(imageUrl.lowercased())
                }
            }
            //whether its successfull or failed, update the progress and notify the observers
            self.imageDownloadInProgress.remove(imageUrl.lowercased())
            let userData = ["image_key":imageUrl]
            NotificationCenter.default.post(name: Constants.ImageDownloadCompletionNotificationName, object: nil, userInfo: userData)
        }
        //add it to queue
        NetworkOperationsQueue.defaultQueue().addOperation(operation: imageDownloadOperation, withPriority: withPriority)
    }
    
    func isDownloadingPoster(forMovie movie:Movie)->Bool
    {
        //Check if poster URL is there
        if let posterURL = movie.Poster
        {
            let validUrl = posterURL.trim().lowercased()
            return self.imageDownloadInProgress.contains(validUrl)
        }
        return false
    }
    
    ///Cleans up local data structs
    func cleanup() {
        self.failedURLs.removeAll()
        NetworkOperationsQueue.defaultQueue().cancelAllOperations()
    }
}
