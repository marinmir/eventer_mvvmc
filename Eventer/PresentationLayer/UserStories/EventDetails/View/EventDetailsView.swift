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
    private let eventCardView = EventFullSizeCard()
    
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
        if let imageUrl = viewModel.eventDetails.titleImage {
            titleImage.loadImage(url: imageUrl)
        } else {
            titleImage.image = Asset.eventDefault.image
        }
        
        eventCardView.configure(with: viewModel.eventDetails)
    }

    // MARK: - Private methods

    private func setupViews() {
        addSubview(titleImage)
        addSubview(eventCardView)
    }

    private func setConstraints() {
        titleImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        eventCardView.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(-10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
