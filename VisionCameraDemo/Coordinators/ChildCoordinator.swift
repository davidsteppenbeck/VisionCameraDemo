//
//  ChildCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/18.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

protocol ChildCoordinator: class {

    /// Keeps a reference to its parent coordinator. Use `weak` to avoid retain cycles.
    var parent: ParentCoordinator? { get set }

}
