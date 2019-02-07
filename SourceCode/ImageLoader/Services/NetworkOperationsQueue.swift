//
//  OperationsQueue.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//
import UIKit
import Foundation

public enum ImageDownloadingPriority: Int
{
    case Default    = 0
    case Immediate
}



class NetworkOperationsQueue: NSObject
{
    private var primaryOperationQueue:OperationQueue?   = nil
    private var maximumOperationsAllowed:NSInteger      = 5
    static let sharedInstance = NetworkOperationsQueue()
    class func defaultQueue() -> NetworkOperationsQueue
    {
        
        return NetworkOperationsQueue.sharedInstance
    }
    
    
    class func queueWithIdentifier(_ identifier:String) -> NetworkOperationsQueue
    {
        let operationQueue = NetworkOperationsQueue()
        operationQueue.primaryOperationQueue = OperationQueue()
        operationQueue.primaryOperationQueue!.maxConcurrentOperationCount = 4
        operationQueue.primaryOperationQueue!.name = identifier
        return operationQueue
    }
    
    fileprivate func primaryQueue()->OperationQueue
    {
        if(self.primaryOperationQueue == nil)
        {
            self.reInitializeOperationQueue()
        }
        return self.primaryOperationQueue!
    }
    
    func reInitializeOperationQueue()
    {
        self.primaryOperationQueue = nil
        self.primaryOperationQueue = OperationQueue()
        self.primaryOperationQueue?.name = "com.demo.imageDownloaderm.networkoperationsqueue"
        self.primaryOperationQueue?.maxConcurrentOperationCount = self.maximumOperationsAllowed
    }
    
    
    @discardableResult
    func addOperation(operation:Operation, withPriority:ImageDownloadingPriority) ->Operation
    {
        switch withPriority {
        case .Immediate:
            operation.qualityOfService = .userInitiated
            break
        case .Default:
            operation.qualityOfService = .default
            break
        }
        self.primaryQueue().addOperation(operation)
        return operation
    }
    
    @discardableResult
    func setMaximumAllowedOperations(maximumOperations:NSInteger)-> NetworkOperationsQueue
    {
        self.maximumOperationsAllowed = maximumOperations
        self.primaryQueue().maxConcurrentOperationCount = self.maximumOperationsAllowed
        NSLog("NetworkOperationsQueue: maxConcurrentOperationCount updated to \(maximumOperationsAllowed)")
        return self
    }
    
    func cancelAllOperations()
    {
        if(self.primaryOperationQueue != nil)
        {
            self.primaryOperationQueue?.cancelAllOperations()
            self.primaryOperationQueue = nil
            self.reInitializeOperationQueue()
            NSLog("NetworkOperationsQueue: All operations has been cancelled.")
        }
    }
    
    
    
    @discardableResult
    func suspendExecution() -> NetworkOperationsQueue
    {
        self.primaryQueue().isSuspended = true
        NSLog("NetworkOperationsQueue: All operations has been Suspended.")
        return self
    }
    
    @discardableResult
    func resumeExecution() -> NetworkOperationsQueue
    {
        self.primaryQueue().isSuspended = false
       NSLog("NetworkOperationsQueue: All operations has been Resumed.")
        return self
    }
    
    func allOperations() -> [Operation]
    {
        return self.primaryQueue().operations
    }
}
