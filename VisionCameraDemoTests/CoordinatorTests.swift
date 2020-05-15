//
//  CoordinatorTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/14.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class CoordinatorTests: XCTestCase {

    var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
    }

    override func tearDown() {
        navigationController = nil
        super.tearDown()
    }

    func testCameraViewControllerCoordinator() throws {
        // Create a camera coordinator.
        let coordinator = CameraCoordinator(navigationController: navigationController)

        // Calling start should create a `CameraViewController` and assign its `coordinator` property.
        coordinator.start()

        // Check the actual value against the expected result.
        let vc = try XCTUnwrap(navigationController.viewControllers.first) as! CameraViewController
        XCTAssertNotNil(vc.coordinator)
    }

    func testSettingsTableViewControllerCoordinator() throws {
        // Create a settings coordinator.
        let coordinator = SettingsCoordinator(navigationController: navigationController)

        // Calling start should create a `SettingsTableViewController` and assign its `coordinator` property.
        coordinator.start()

        // Check the actual value against the expected result.
        let vc = try XCTUnwrap(navigationController.viewControllers.first) as! SettingsTableViewController
        XCTAssertNotNil(vc.coordinator)
    }

    func testCameraCoordinatorChildren() {
        // The camera coordinator should be created with an empty `children` array.
        let coordinator = CameraCoordinator(navigationController: navigationController)

        // Check the actual value against the expected result.
        XCTAssertTrue(coordinator.children.isEmpty)
    }

    func testChildDidFinish() {
        // Create a parent coordinator. The `children` array should be empty.
        let parentCoordinator = MockParentCoordinator(navigationController: navigationController)
        // Check the actual value against the expected result.
        XCTAssertTrue(parentCoordinator.children.isEmpty)

        // Create a child coordinator and add it as a child of the parent coordinator.
        let childCoordinator = MockChildCoordinator(navigationController: navigationController)
        parentCoordinator.children.append(childCoordinator)
        // Check the actual value against the expected result.
        XCTAssertEqual(parentCoordinator.children.count, 1)

        // Calls to this method should remove the child coordinator from the `children` array.
        parentCoordinator.childDidFinish(childCoordinator)
        // Check the actual value against the expected result.
        XCTAssertTrue(parentCoordinator.children.isEmpty)
    }

}

fileprivate class MockParentCoordinator: NSObject, Coordinator, ParentCoordinator {

    var navigationController: UINavigationController

    func start() { }

    var children = [ChildCoordinator & Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

}

fileprivate class MockChildCoordinator: NSObject, Coordinator, ChildCoordinator {

    var navigationController: UINavigationController

    func start() { }

    var parent: ParentCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

}
