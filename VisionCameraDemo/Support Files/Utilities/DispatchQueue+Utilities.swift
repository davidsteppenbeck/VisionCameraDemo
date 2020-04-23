//
//  DispatchQueue+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/19.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension DispatchQueue {

    /// Safely submits a block object for execution on the main queue and returns after that block finishes executing.
    ///
    /// This method first checks the thread that it's being called on. If it's called on the main thread, then the block object will
    /// be executed there immediately. Otherwise, if the thread is not the main thread, the method will dispatch the block object
    /// to the main thread synchronously.
    ///
    /// - Parameters:
    ///   - block: The block containing the work to perform. This block has no return value and no parameters.
    class func mainSyncSafe(execute block: () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync(execute: block)
        }
    }

}
