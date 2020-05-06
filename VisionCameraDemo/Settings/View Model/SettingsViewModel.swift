//
//  SettingsViewModel.swift
//  VisionCameraDemo
//
//  Created by David Steppenbeck on 2020/04/29.
//  Copyright © 2020 David Steppenbeck. All rights reserved.
//

import Foundation
import Combine

final class SettingsViewModel {

    // MARK:- Properties

    let model: SettingsModel

    private let dataPersistenceManager: SettingsDataPersistenceManager

    /// An array to keep references to `AnyCancellable` subscribers.
    private var subscriptions = [AnyCancellable]()

    /// Formatted text for the video resolution option label.
    @Published var videoResolutionOptionText: String?

    /// Formatted text for the appearance option label.
    @Published var appearanceOptionText: String?

    /// A formatted title to display to the user.
    var title: String {
        return model.title.capitalized
    }

    var isShowCameraGridSwitchOn: Bool {
        get {
            return model.showCameraGrid
        }
        set {
            if newValue != model.showCameraGrid {
                model.showCameraGrid = newValue
            }
        }
    }

    var isSaveSnapshotsSwitchOn: Bool {
        get {
            return model.saveSnapshots
        }
        set {
            if newValue != model.saveSnapshots {
                model.saveSnapshots = newValue
            }
        }
    }

    var videoResolution: VideoResolution {
        get {
            return model.videoResolution
        }
        set {
            if newValue != model.videoResolution {
                model.videoResolution = newValue
            }
        }
    }

    var appearance: Appearance {
        get {
            return model.appearance
        }
        set {
            if newValue != model.appearance {
                model.appearance = newValue
            }
        }
    }

    // MARK:- Methods

    private func addModelSubscribers() {
        subscriptions += model.$showCameraGrid.sink { [weak self] showCameraGrid in
            NotificationCenter.default.post(name: .showCameraGrid, object: self, value: showCameraGrid)
            self?.dataPersistenceManager.storeShowCameraGridSetting(showCameraGrid)
        }

        subscriptions += model.$saveSnapshots.sink { [weak self] saveSnapshots in
            NotificationCenter.default.post(name: .saveSnapshots, object: self, value: saveSnapshots)
            self?.dataPersistenceManager.storeSaveSnapshotsSetting(saveSnapshots)
        }

        subscriptions += model.$videoResolution.sink { [weak self] videoResolution in
            NotificationCenter.default.post(name: .videoResolution, object: self, value: videoResolution)
            self?.videoResolutionOptionText = videoResolution.description.capitalized
            self?.dataPersistenceManager.storeVideoResolutionSetting(videoResolution)
        }

        subscriptions += model.$appearance.sink { [weak self] appearance in
            AppearanceManager.updateUserInterfaceStyle(for: appearance)
            self?.appearanceOptionText = appearance.description.capitalized
            self?.dataPersistenceManager.storeAppearanceSetting(appearance)
        }
    }

    // MARK:- Initialization

    init(model: SettingsModel, dataPersistenceManager: SettingsDataPersistenceManager) {
        self.model = model
        self.dataPersistenceManager = dataPersistenceManager
        addModelSubscribers()
    }

}
