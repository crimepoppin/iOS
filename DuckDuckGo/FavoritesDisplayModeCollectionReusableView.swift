//
//  FavoritesDisplayModeCollectionReusableView.swift
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

class FavoritesDisplayModeCollectionReusableView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    static let reuseIdentifier = "FavoritesDisplayModeCollectionReusableView"
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        layoutIfNeeded()
    }

    @IBAction private func showSettings() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "HomePageSettingsViewController")
                as? HomePageSettingsViewController
        else {
            fatalError("Failed to instantiate tabs bar controller")
        }
        let navController = UINavigationController(rootViewController: controller)
        if #available(iOS 15.0, *) {
            navController.sheetPresentationController?.detents = [.medium()]
        }
        guard let window = window, let rootViewController = window.rootViewController as? MainViewController else { return }
        rootViewController.present(navController, animated: true)
    }
}

extension FavoritesDisplayModeCollectionReusableView: Themable {

    func decorate(with theme: Theme) {
        button.backgroundColor = UIColor(designSystemColor: .container)
        button.setTitleColor(theme.barTintColor, for: .normal)
    }

}
