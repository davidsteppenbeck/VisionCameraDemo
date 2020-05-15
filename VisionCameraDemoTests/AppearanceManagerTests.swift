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
        // Should assign dark user interface style to all application windows.
        AppearanceManager.updateUserInterfaceStyle(for: .dark)
        // Check the actual value against the expected result.
        XCTAssertEqual(UIApplication.shared.windows.first!.overrideUserInterfaceStyle, UIUserInterfaceStyle.dark)

        // Should assign light user interface style to all application windows.
        AppearanceManager.updateUserInterfaceStyle(for: .light)
        // Check the actual value against the expected result.
        XCTAssertEqual(UIApplication.shared.windows.first!.overrideUserInterfaceStyle, UIUserInterfaceStyle.light)

        // Should assign the system user interface style to all application windows.
        AppearanceManager.updateUserInterfaceStyle(for: .system)
        // Check the actual value against the expected result.
        XCTAssertEqual(UIApplication.shared.windows.first!.overrideUserInterfaceStyle, UIUserInterfaceStyle.unspecified)
    }

}
