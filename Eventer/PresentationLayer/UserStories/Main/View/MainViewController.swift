//
//  MainViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd.. All rights reserved.
//

import UIKit

final class MainViewController: UITabBarController {

    // MARK: - Private properties

    private let viewModel: MainViewModelBindable

    // MARK: - Initializers

    init(viewModel: MainViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }

    override func viewWillAppear(_ animated: Bool) {
        centerTabBarItems()
    }

    private func centerTabBarItems() {
        if let controllers = viewControllers {
            for vc in controllers {
                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
            }
        }
    }

    private func setupAppearance() {
        tabBar.tintColor = Asset.Colors.darkViolet.color
        tabBar.backgroundColor = Asset.Colors.white.color
        tabBar.barTintColor = Asset.Colors.white.color

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = Asset.Colors.white.color
        UINavigationBar.appearance().backgroundColor = Asset.Colors.white.color
    }
}
