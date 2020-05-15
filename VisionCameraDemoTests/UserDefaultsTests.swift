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

    func testUserDefaultPropertyWrapperForBool() {
        // Check the default value.
        XCTAssertTrue(MockUserDefaults.testBool)

        // Should assign and store the new value.
        MockUserDefaults.testBool = false

        // Check the actual value against the expected result.
        XCTAssertFalse(MockUserDefaults.testBool)
    }

    func testUserDefaultPropertyWrapperForString() {
        // Check the default value.
        XCTAssertEqual(MockUserDefaults.testString, "Test String")

        // Should assign and store the new value.
        MockUserDefaults.testString = "A New String"

        // Check the actual value against the expected result.
        XCTAssertEqual(MockUserDefaults.testString, "A New String")
    }

    func testRawRepresentableUserDefaultPropertyWrapper() {
        // Check the default value.
        XCTAssertEqual(MockUserDefaults.testRawRepresentableEnum, RawRepresentableEnum.apple)

        // Should assign and store the new value.
        MockUserDefaults.testRawRepresentableEnum = .banana

        // Check the actual value against the expected result.
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

// Call at tear down to remove test data from user defaults.
fileprivate func clearUserDefaultsTestValues() {
    UserDefaults.standard.set(nil, forKey: "test_bool")
    UserDefaults.standard.set(nil, forKey: "test_string")
    UserDefaults.standard.set(nil, forKey: "test_raw_representable_enum")
}
