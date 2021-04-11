//
//  EventDetailsView.swift
//  Eventer
//
//  Created by Ярослав Магин on 11/04/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class EventDetailsView: UIView {

    // MARK: - Private properties

    private let titleImage = UIImageView()
    
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupViews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: EventDetailsViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }

    // MARK: - Private methods

    private func setupViews() {

    }

    private func setConstraints() {

    }
}
