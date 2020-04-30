//
//  Comparable+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension Comparable {

    /// Provides a value that lies within the supplied limits.
    /// If the value lies outside of the limits, it will be capped to
    /// the nearest limit. The limits can be supplied as either `capped(min, max)`
    /// or `capped(max, min)` --- the order is not important.
    ///
    /// As an example for integers, `0.capped(1, 3)` will return `1`, and
    /// `8.capped(7, 2)` will return `7`. However, if the value already lies within
    /// the supplied range, then that value will be returned; for example, `5.capped(3, 8)`
    /// returns `5`.
    ///
    /// - Parameters:
    ///   - limit1: The first limit. Can be either the lower or upper limit, provided `limit2` is the other.
    ///   - limit2: The second limit. Can be either the lower or upper limit, provided `limit1` is the other.
    ///
    /// - Returns: The capped value.
    func capped(_ limit1: Self, _ limit2: Self) -> Self {
        let lowerLimit = min(limit1, limit2)
        let upperLimit = max(limit1, limit2)
        return min(max(self, lowerLimit), upperLimit)
    }

}
