//
//  EventDetailsViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 11/04/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import UIKit

final class EventDetailsViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: EventDetailsViewModelBindable

    // MARK: - Initializers

    init(viewModel: EventDetailsViewModelBindable) {
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

        let view = EventDetailsView()
        view.bind(to: viewModel)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
