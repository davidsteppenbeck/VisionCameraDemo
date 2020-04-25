//
//  TwitterManager.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/24.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

/// A manager that handles linking to and opening the developer's Twitter account.
struct TwitterManager: SocialMediaManager {

    // MARK:- Properties

    static let shared = TwitterManager()

    let screenName = "dsteppenbeck"

    var handle: String {
        return "@" + screenName
    }

    private let urlString: [SocialMediaUrlType: String] = [
        .app: "twitter://user?screen_name=",
        .web: "https://twitter.com/"
    ]

    // MARK:- Methods

    func url(for type: SocialMediaUrlType) -> URL? {
        if let urlString = urlString[type], let url = URL(string: urlString + screenName) {
            return url
        } else {
            return nil
        }
    }

}
