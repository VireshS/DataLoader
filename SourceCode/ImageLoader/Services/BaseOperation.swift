//
//  BaseOperation.swift
//  ImageLoader
//
//  Created by Viresh Singh on 06/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit

@objcMembers
public class BaseOperation: Operation
{
    private var _executing : Bool = false
    override public var isExecuting : Bool {
        get { return _executing }
        set {
            guard _executing != newValue else { return }
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    
    private var _finished : Bool = false
    override public var isFinished : Bool {
        get { return _finished }
        set {
            guard _finished != newValue else { return }
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _cancelled : Bool = false
    override public var isCancelled: Bool {
        get { return _cancelled }
        set {
            guard _cancelled != newValue else { return }
            willChangeValue(forKey: "isCancelled")
            _cancelled = newValue
            didChangeValue(forKey: "isCancelled")
        }
    }
    
    override public var isConcurrent: Bool{
        get {return true}
    }
    
    override public func cancel()
    {
        self.isCancelled = true
        if(self.isExecuting)
        {
            self.isExecuting = false
        }
    }
    
    
    func finishOperation()
    {
        if(!self.isExecuting)
        {
            //Just to make sure that its called only for executing operations.
            return;
        }
        if(self.isExecuting)
        {
            self.isExecuting = false
        }
        self.isFinished  = true
    }
    
    
    func markExecuting()
    {
        self.isExecuting = true
    }
}
