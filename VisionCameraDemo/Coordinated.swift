//
//  Coordinated.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/11.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import UIKit

protocol Coordinated: class {
    var navigationController: UINavigationController { get set }
    var children: [Coordinated] { get set }
    func start()
}
