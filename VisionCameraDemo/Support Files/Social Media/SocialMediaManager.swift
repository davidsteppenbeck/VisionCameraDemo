//
//  SocialMediaManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/24.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

protocol SocialMediaManager {

    /// The social media account screen name.
    static var screenName: String { get set }

    /// The social media account handle.
    static var handle: String { get }

    /// Provides the URL string for a given `SocialMediaUrlType`.
    var urlString: [SocialMediaUrlType: String] { get }

    /// Provides the URL for a given `SocialMediaUrlType`.
    ///
    /// - Parameters:
    ///   - type: The `SocialMediaUrlType` requested.
    ///
    /// - Returns: The URL for the requested `SocialMediaUrlType`, if it exists. Otherwise returns `nil`.
    func url(for type: SocialMediaUrlType) -> URL?

}
