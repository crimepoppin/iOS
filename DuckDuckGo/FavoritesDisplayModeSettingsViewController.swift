//
//  FavoritesDisplayModeSettingsViewController.swift
//  DuckDuckGo
//
//  Copyright © 2023 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import Bookmarks
import Core

class FavoritesDisplayModeSettingsViewController: UITableViewController {

    private lazy var appSettings = AppDependencyProvider.shared.appSettings

    private lazy var availableDisplayModes = FavoritesDisplayMode.availableConfigurations

    override func viewDidLoad() {
        super.viewDidLoad()

        applyTheme(ThemeManager.shared.currentTheme)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UserText.favoritesDisplayPreferencesHeader
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return UserText.favoritesDisplayPreferencesFooter
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableDisplayModes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "FavoritesDisplayModeCell", for: indexPath)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let theme = ThemeManager.shared.currentTheme
        cell.backgroundColor = theme.tableCellBackgroundColor
        cell.setHighlightedStateBackgroundColor(theme.tableCellHighlightedBackgroundColor)

        // Checkmark color
        cell.tintColor = theme.buttonTintColor
        cell.imageView?.tintColor = theme.ddgTextTintColor
        cell.textLabel?.textColor = theme.tableCellTextColor
        cell.textLabel?.font = UIFont.appFont(ofSize: 16)

        let displayMode = availableDisplayModes[indexPath.row]
        cell.textLabel?.text = displayMode.displayString
        cell.imageView?.image = displayMode.image

        cell.accessoryType = displayMode == appSettings.favoritesDisplayMode ? .checkmark : .none
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let displayMode = availableDisplayModes[indexPath.row]
        appSettings.favoritesDisplayMode = displayMode
        NotificationCenter.default.post(name: AppUserDefaults.Notifications.favoritesDisplayModeChange, object: self)
        tableView.reloadData()
    }
}

extension FavoritesDisplayModeSettingsViewController: Themable {

    func decorate(with theme: Theme) {

        tableView.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.tableCellSeparatorColor

        tableView.reloadData()
    }
}
