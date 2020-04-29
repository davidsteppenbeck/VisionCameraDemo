//
//  ParentCoordinator.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/18.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation

protocol ParentCoordinator: class {

    /// Keeps a reference to each of its child coordinators.
    var children: [Coordinator & ChildCoordinator] { get set }

    /// Call to remove the child coordinator from its parent once its finished with.
    ///
    /// - Parameters:
    ///   - child: The child coordinator that has finished controlling the navigation flow.
    func childDidFinish(_ child: Coordinator?)

}

extension ParentCoordinator {

    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else {
            return
        }

        for (index, coordinator) in children.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }

}
