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
    }

    override func tearDown() {
        if observers != nil {
            for observer in observers {
                NotificationCenter.default.removeObserver(observer)
            }
        }

        observers = nil
        model = nil
        sut = nil
        super.tearDown()
    }

    func testTitle() {
        XCTAssertEqual(sut.title, "Title")
    }

    func testIsShowCameraGridSwitchOn() {
        XCTAssertTrue(sut.isShowCameraGridSwitchOn)
        sut.isShowCameraGridSwitchOn = false
        XCTAssertFalse(sut.isShowCameraGridSwitchOn)
    }

    func testIsSaveSnapshotsSwitchOn() {
        XCTAssertFalse(sut.isSaveSnapshotsSwitchOn)
        sut.isSaveSnapshotsSwitchOn = true
        XCTAssertTrue(sut.isSaveSnapshotsSwitchOn)
    }

    func testVideoResolution() {
        XCTAssertEqual(sut.videoResolution, VideoResolution.high)
        sut.videoResolution = .photo
        XCTAssertEqual(sut.videoResolution, VideoResolution.photo)
    }

    func testAppearance() {
        XCTAssertEqual(sut.appearance, Appearance.system)
        sut.appearance = .dark
        XCTAssertEqual(sut.appearance, Appearance.dark)
    }

    func testVideoResolutionOptionText() throws {
        do {
            let text = try XCTUnwrap(sut.videoResolutionOptionText)
            XCTAssertEqual(text, sut.videoResolution.description.capitalized)
        } catch {
            throw error
        }
    }

    func testAppearanceOptionText() throws {
        do {
            let text = try XCTUnwrap(sut.appearanceOptionText)
            XCTAssertEqual(text, sut.appearance.description.capitalized)
        } catch {
            throw error
        }
    }

    func testSubscriberShowCameraGridNotification() {
        let notificationExpectation = expectation(description: "Show camera grid notification.")

        let observer = NotificationCenter.default.addObserver(
            forName: .showCameraGrid,
            object: nil,
            queue: .main,
            using: { _ in
                notificationExpectation.fulfill()
            }
        )

        // Keep a reference so that it can be removed in the tear down method.
        observers = [observer]

        // This will assign the model a new value, which in turn calls the subscriber
        // that posts the notification.
        sut.isShowCameraGridSwitchOn = false

        waitForExpectations(timeout: 1)
    }

    func testSubscriberSaveSnaphotsNotification() {
        let notificationExpectation = expectation(description: "Save snapshots notification.")

        let observer = NotificationCenter.default.addObserver(
            forName: .saveSnapshots,
            object: nil,
            queue: .main,
            using: { _ in
                notificationExpectation.fulfill()
            }
        )

        // Keep a reference so that it can be removed in the tear down method.
        observers = [observer]

        // This will assign the model a new value, which in turn calls the subscriber
        // that posts the notification.
        sut.isSaveSnapshotsSwitchOn = true

        waitForExpectations(timeout: 1)
    }

    func testSubscriberVideoResolutionNotification() {
        let notificationExpectation = expectation(description: "Video resolution notification.")

        let observer = NotificationCenter.default.addObserver(
            forName: .videoResolution,
            object: nil,
            queue: .main,
            using: { _ in
                notificationExpectation.fulfill()
            }
        )

        // Keep a reference so that it can be removed in the tear down method.
        observers = [observer]

        // This will assign the model a new value, which in turn calls the subscriber
        // that posts the notification.
        sut.videoResolution = .photo

        waitForExpectations(timeout: 1)
    }

    func testAppearanceSubscriber() {
        AppearanceManager.updateUserInterfaceStyle(for: .system)

        // This will assign the model a new value, which in turn calls the
        // appearance manager to update the value.
        sut.appearance = .dark

        let overrideUserInterfaceStyle = UIApplication.shared.windows.first!.overrideUserInterfaceStyle
        XCTAssertEqual(overrideUserInterfaceStyle, UIUserInterfaceStyle.dark)
    }

    func testDataPersistenceManagerStoreShowCameraGridSetting() {
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.showCameraGrid)

        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)
        XCTAssertTrue(mockDataPersistenceManager.showCameraGrid)
    }

    func testDataPersistenceManagerStoreSaveSnapshotsSetting() {
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.saveSnapshots)

        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)
        XCTAssertFalse(mockDataPersistenceManager.saveSnapshots)
    }

    func testDataPersistenceManagerStoreVideoResolutionSetting() {
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.videoResolution)

        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)
        XCTAssertEqual(mockDataPersistenceManager.videoResolution, VideoResolution.high)
    }

    func testDataPersistenceManagerStoreAppearanceSetting() {
        let mockDataPersistenceManager = MockDataPersistenceManager()
        XCTAssertNil(mockDataPersistenceManager.appearance)

        _ = SettingsViewModel(model: model, dataPersistenceManager: mockDataPersistenceManager)
        XCTAssertEqual(mockDataPersistenceManager.appearance, Appearance.system)
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
