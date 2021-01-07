//
//  ProfileView.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxSwift
import UIKit

final class ProfileView: UIView {

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: ProfileViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }
}
