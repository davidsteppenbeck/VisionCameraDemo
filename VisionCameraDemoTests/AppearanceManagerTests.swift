//
//  AppearanceManagerTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/08.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class AppearanceManagerTests: XCTestCase {

    func testUpdateUserInterfaceStyle() {
        AppearanceManager.updateUserInterfaceStyle(for: .dark)
        XCTAssertEqual(UIApplication.shared.windows.first!.overrideUserInterfaceStyle, UIUserInterfaceStyle.dark)

        AppearanceManager.updateUserInterfaceStyle(for: .light)
        XCTAssertEqual(UIApplication.shared.windows.first!.overrideUserInterfaceStyle, UIUserInterfaceStyle.light)

        AppearanceManager.updateUserInterfaceStyle(for: .system)
        XCTAssertEqual(UIApplication.shared.windows.first!.overrideUserInterfaceStyle, UIUserInterfaceStyle.unspecified)
    }

}
