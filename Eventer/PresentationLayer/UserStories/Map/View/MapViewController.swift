//
//  MapViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import UIKit

final class MapViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: MapViewModelBindable

    // MARK: - Initializers

    init(viewModel: MapViewModelBindable) {
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

        let view = MapView()
        view.bind(to: viewModel)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
