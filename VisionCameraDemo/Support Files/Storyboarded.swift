//
//  Storyboarded.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

/// Methods for instantiating view controllers from storyboards.
protocol Storyboarded: class {
    static func instantiate(withStoryboardName name: String, bundle: Bundle?) -> Self
}

extension Storyboarded {

    /// Default implementation that instantiates the view controller from the storyboard.
    /// This requires applying a Storyboard ID that is the same as the view controller class name.
    ///
    /// - Parameters:
    ///   - name: The name of the storyboard file that contains the view controller. Defaults to "Main".
    ///   - bundle: The bundle containing the storyboard file and its related resources. If you specify nil,
    ///   this method looks in the main bundle of the current application. Defaults to nil.
    ///
    /// - Returns: A new instance of the view controller.
    static func instantiate(withStoryboardName name: String = "Main", bundle: Bundle? = nil) -> Self {

        /// Provides the class name as a `String`.
        let id = String(describing: self)

        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }

}
