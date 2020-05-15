//
//  SettingsViewModelTests.swift
//  VisionCameraDemoTests
//
//  Created by David Steppenbeck on 2020/05/07.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import XCTest
@testable import VisionCameraDemo

final class SettingsViewModelTests: XCTestCase {

    var model: SettingsModel!

    var sut: SettingsViewModel!

    var observers: [NSObjectProtocol]!

    override func setUp() {
        super.setUp()
        model = SettingsModel(title: "title", showCameraGrid: true, saveSnapshots: false, videoResolution: .high, appearance: .system)
        sut = SettingsViewModel(model: model, dataPersistenceManager: nil)
        observers = []
    }

    override func tearDown() {
        if observers != nil {
            for observer in observers {
                NotificationCenter.default.removeObserver(observer)
            }
        }

        observers = nil
        sut = nil
        model = nil
        super.tearDown()
    }

    func testTitle() {
        // The view model title should be a capitalized version the model value.
        let title = sut.title

        // Check the actual value against the expected result.
        XCTAssertEqual(title, "Title")
    }

    func testIsShowCameraGridSwitchOn() {
        // The view model value should match the model's initial value.
        XCTAssertTrue(sut.isShowCameraGridSwitchOn)

        // Updating the view model should update the model.
        sut.isShowCameraGridSwitchOn = false

        // Check the actual value against the expected result.
        XCTAssertFalse(sut.isShowCameraGridSwitchOn)
    }

    func testIsSaveSnapshotsSwitchOn() {
        // The view model value should match the model's initial value.
        XCTAssertFalse(sut.isSaveSnapshotsSwitchOn)

        // Updating the view model should update the model.
        sut.isSaveSnapshotsSwitchOn = true

        // Check the actual value against the expected result.
        XCTAssertTrue(sut.isSaveSnapshotsSwitchOn)
    }

    func testVideoResolution() {
        // The view model value should match the model's initial value.
        XCTAssertEqual(sut.videoResolution, VideoResolution.high)

        // Updating the view model should update the model.
        sut.videoResolution = .photo

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.videoResolution, VideoResolution.photo)
    }

    func testAppearance() {
        // The view model value should match the model's initial value.
        XCTAssertEqual(sut.appearance, Appearance.system)

        // Updating the view model should update the model.
        sut.appearance = .dark

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.appearance, Appearance.dark)
    }

    func testVideoResolutionOptionText() throws {
        // Should return a manipulated version of the model value.
        let text = try XCTUnwrap(sut.videoResolutionOptionText)

        // Check the actual value against the expected result.
        XCTAssertEqual(text, sut.videoResolution.description.capitalized)
    }

    func testAppearanceOptionText() throws {
        // Should return a manipulated version of the model value.
        let text = try XCTUnwrap(sut.appearanceOptionText)

        // Check the actual value against the expected result.
        XCTAssertEqual(text, sut.appearance.description.capitalized)
    }

    func testSubscriberShowCameraGridNotification() {
        // Create an expectation to fulfill.
        let notificationExpectation = expectation(description: "Show camera grid notification.")

        // Add an observer to the `showCameraGrid` notification.
        let observer = NotificationCenter.default.addObserver(
            forName: .showCameraGrid,
            object: nil,
            queue: .main,
            using: { _ in
                notificationExpectation.fulfill()
            }
        )

        // Must keep a reference outside of the scopr so that the observer can be removed in the tear down method.
        observers = [observer]

        // Assigning the view model value should assign the model a new value, which in turn calls the subscriber
        // that posts the notification and fulfills the expectation.
        sut.isShowCameraGridSwitchOn = false

        // Wait for the expectation to be fulfilled.
        waitForExpectations(timeout: 1)
    }

    func testSubscriberSaveSnaphotsNotification() {
        // Create an expectation to fulfill.
        let notificationExpectation = expectation(description: "Save snapshots notification.")

        // Add an observer to the `saveSnapshots` notification.
        let observer = NotificationCenter.default.addObserver(
            forName: .saveSnapshots,
            object: nil,
            queue: .main,
            using: { _ in
                notificationExpectation.fulfill()
            }
        )

        // Must keep a reference outside of the scopr so that the observer can be removed in the tear down method.
        observers = [observer]

        // Assigning the view model value should assign the model a new value, which in turn calls the subscriber
        // that posts the notification and fulfills the expectation.
        sut.isSaveSnapshotsSwitchOn = true

        // Wait for the expectation to be fulfilled.
        waitForExpectations(timeout: 1)
    }

    func testSubscriberVideoResolutionNotification() {
        // Create an expectation to fulfill.
        let notificationExpectation = expectation(description: "Video resolution notification.")

        // Add an observer to the `videoResolution` notification.
        let observer = NotificationCenter.default.addObserver(
            forName: .videoResolution,
            object: nil,
            queue: .main,
            using: { _ in
                notificationExpectation.fulfill()
            }
        )

        // Must keep a reference outside of the scopr so that the observer can be removed in the tear down method.
        observers = [observer]

        // Assigning the view model value should assign the model a new value, which in turn calls the subscriber
        // that posts the notification and fulfills the expectation.
        sut.videoResolution = .photo

        // Wait for the expectation to be fulfilled.
        waitForExpectations(timeout: 1)
    }

    func testAppearanceSubscriber() {
        // Set the user interface style to match the system style to begin.
        AppearanceManager.updateUserInterfaceStyle(for: .system)

        // Assigning the view model value should assign the model a new value, which in turn calls the
        // appearance manager and updates the value.
        sut.appearance = .dark

        // The user interface style should now be dark.
        let overrideUserInterfaceStyle = UIApplication.shared.windows.first!.overrideUserInterfaceStyle
        // Check the actual value against the expected result.
        XCTAssertEqual(overrideUserInterfaceStyle, UIUserInterfaceStyle.dark)
    }

    func testDataPersistenceManagerStoreShowCameraGridSetting() {
        // Create and check a mock data persistence manager. All its properties should be nil.
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.showCameraGrid)

        // Should pass the model values to the mock data persistence manager and "save" the values.
        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)

        // Check the actual value against the expected result.
        XCTAssertTrue(mockDataPersistenceManager.showCameraGrid)
    }

    func testDataPersistenceManagerStoreSaveSnapshotsSetting() {
        // Create and check a mock data persistence manager. All its properties should be nil.
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.saveSnapshots)

        // Should pass the model values to the mock data persistence manager and "save" the values.
        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)

        // Check the actual value against the expected result.
        XCTAssertFalse(mockDataPersistenceManager.saveSnapshots)
    }

    func testDataPersistenceManagerStoreVideoResolutionSetting() {
        // Create and check a mock data persistence manager. All its properties should be nil.
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.videoResolution)

        // Should pass the model values to the mock data persistence manager and "save" the values.
        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)

        // Check the actual value against the expected result.
        XCTAssertEqual(mockDataPersistenceManager.videoResolution, VideoResolution.high)
    }

    func testDataPersistenceManagerStoreAppearanceSetting() {
        // Create and check a mock data persistence manager. All its properties should be nil.
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.appearance)

        // Should pass the model values to the mock data persistence manager and "save" the values.
        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)

        // Check the actual value against the expected result.
        XCTAssertEqual(mockDataPersistenceManager.appearance, Appearance.system)
    }

    func testMakeForUserDefaults() {
        // The view model values should be the same as those in `UserDefaults`.
        let sut = SettingsViewModel.makeForUserDefaults()

        // The data persistence manager should be assigned.
        XCTAssertNotNil(sut.dataPersistenceManager)

        // Check the actual value against the expected result.
        XCTAssertEqual(sut.isShowCameraGridSwitchOn, UserDefaults.showCameraGrid)
        XCTAssertEqual(sut.isSaveSnapshotsSwitchOn, UserDefaults.saveSnapshots)
        XCTAssertEqual(sut.videoResolution, UserDefaults.videoResolution)
        XCTAssertEqual(sut.appearance, UserDefaults.appearance)
    }

}

fileprivate class MockDataPersistenceManager: SettingsDataPersistenceManager {

    var showCameraGrid: Bool!
    var saveSnapshots: Bool!
    var videoResolution: VideoResolution!
    var appearance: Appearance!

    func storeShowCameraGridSetting(_ value: Bool) {
        showCameraGrid = value
    }

    func storeSaveSnapshotsSetting(_ value: Bool) {
        saveSnapshots = value
    }

    func storeVideoResolutionSetting(_ value: VideoResolution) {
        videoResolution = value
    }

    func storeAppearanceSetting(_ value: Appearance) {
        appearance = value
    }

}
