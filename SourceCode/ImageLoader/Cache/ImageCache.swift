//
//  ImageCache.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit
import Foundation

class ImageCache {

    static let defaultCache:NSCache<AnyObject,AnyObject> = NSCache<AnyObject,AnyObject>()
    
    ///cache the provided image
    class func cache(image imageToCache:UIImage, forKey key:String)
    {
        ImageCache.defaultCache.setObject(imageToCache, forKey: key.lowercased() as AnyObject)
    }
    
    ///Returns the cached image for given key
    class func image(forKey imageKey:String)->UIImage?
    {
        if let cachedImage = ImageCache.defaultCache.object(forKey: imageKey.lowercased() as AnyObject)
        {
            return cachedImage as? UIImage
        }
        return nil
    }
    
    ///clears the cache
    class func discardCache()
    {
        ImageCache.defaultCache.removeAllObjects()
    }
}
