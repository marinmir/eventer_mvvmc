//
//  LoginViewController.swift
//  Eventer
//
//  Created by Yaroslav Magin on 10/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: LoginViewModelBindable

    // MARK: - Initializers

    init(viewModel: LoginViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        super.loadView()

        let view = LoginView()
        view.bind(to: viewModel)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
