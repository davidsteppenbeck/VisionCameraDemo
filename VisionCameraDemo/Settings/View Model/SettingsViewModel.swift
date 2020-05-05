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

    @Published var appearanceOptionText: String?

    /// A formatted title to display to the user.
    var title: String {
        return model.title.capitalized
    }

    var isShowCameraGridSwitchOn: Bool {
        get { return model.showCameraGrid }
        set { model.showCameraGrid = newValue }
    }

    var isSaveSnapshotsSwitchOn: Bool {
        get { return model.saveSnapshots }
        set { model.saveSnapshots = newValue }
    }

    var appearance: Appearance {
        get { return model.appearance }
        set { model.appearance = newValue }
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

        subscriptions += model.$appearance.sink { [weak self] appearance in
            var appearanceOptionText: String {
                switch appearance {
                case .dark: return "Dark"
                case .light: return "Light"
                case .system: return "System"
                }
            }

            self?.appearanceOptionText = appearanceOptionText
            AppearanceManager.updateUserInterfaceStyle(for: appearance)
            self?.dataPersistenceManager.storeAppearanceSetting(appearance)
        }
    }

    // MARK:- Initialization

    init(model: SettingsModel, dataPersistenceManager: SettingsDataPersistenceManager) {
        self.model = model
        self.dataPersistenceManager = dataPersistenceManager
        addModelSubscribers()
    }

    // MARK:- Deinitialization

    deinit {
        // TODO: Delete deinit
        print("SettingsViewModel deinit")
    }

}
