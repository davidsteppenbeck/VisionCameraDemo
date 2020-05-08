//
//  UserDefaultsTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/08.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class UserDefaultsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        clearUserDefaultsTestValues()
    }

    override func tearDown() {
        clearUserDefaultsTestValues()
        super.tearDown()
    }

    private func clearUserDefaultsTestValues() {
        UserDefaults.standard.set(nil, forKey: "test_bool")
        UserDefaults.standard.set(nil, forKey: "test_string")
        UserDefaults.standard.set(nil, forKey: "test_raw_representable_enum")
    }

    func testUserDefaultPropertyWrapper() {
        XCTAssertTrue(MockUserDefaults.testBool)
        MockUserDefaults.testBool = false
        XCTAssertFalse(MockUserDefaults.testBool)

        XCTAssertEqual(MockUserDefaults.testString, "Test String")
        MockUserDefaults.testString = "A New String"
        XCTAssertEqual(MockUserDefaults.testString, "A New String")
    }

    func testRawRepresentableUserDefaultPropertyWrapper() {
        XCTAssertEqual(MockUserDefaults.testRawRepresentableEnum, RawRepresentableEnum.apple)
        MockUserDefaults.testRawRepresentableEnum = .banana
        XCTAssertEqual(MockUserDefaults.testRawRepresentableEnum, RawRepresentableEnum.banana)
    }
}

fileprivate struct MockUserDefaults {

    @UserDefault(key: "test_bool", defaultValue: true)
    static var testBool: Bool

    @UserDefault(key: "test_string", defaultValue: "Test String")
    static var testString: String
    
    @RawRepresentableUserDefault(key: "test_raw_representable_enum", defaultValue: .apple)
    static var testRawRepresentableEnum: RawRepresentableEnum

}

fileprivate enum RawRepresentableEnum: Int {
    case apple
    case banana
}
