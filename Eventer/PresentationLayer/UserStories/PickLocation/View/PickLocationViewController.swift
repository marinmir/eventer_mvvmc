//
//  PickLocationViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 25/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import UIKit

final class PickLocationViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: PickLocationViewModelBindable

    // MARK: - Initializers

    init(viewModel: PickLocationViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        let view = PickLocationView()
        view.bind(to: viewModel)

        self.view = view
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = L10n.PickLocation.title
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: L10n.PickLocation.cancel,
            style: .plain,
            target: self,
            action: #selector(onCancel)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: L10n.PickLocation.accept,
            style: .plain,
            target: self,
            action: #selector(onAccept)
        )
    }
    
    @objc private func onCancel() {
        viewModel.onCancel()
    }
    
    @objc private func onAccept() {
        viewModel.onAccept()
    }
}
