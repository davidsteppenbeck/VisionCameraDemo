//
//  Array+Utilities.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/05/02.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

extension Array {

    /// Appends the element to the array.
    ///
    /// - Parameters:
    ///   - lhs: The array to add the element to.
    ///   - rhs: The element to be appended.
    static func += (lhs: inout Array<Element>, rhs: Element) {
        lhs += [rhs]
    }

}
