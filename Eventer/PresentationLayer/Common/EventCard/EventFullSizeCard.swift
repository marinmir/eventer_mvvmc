//
//  EventFullSizeCard.swift
//  Eventer
//
//  Created by Ярослав Магин on 11.04.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

final class EventFullSizeCard: UIView {
    // MARK: - Private properties
    
    private let scroll = UIScrollView()
    private let contentStack = UIStackView()
    
    private let topContainer = UIView()
    private let titleLabel = UILabel()
    private let likeButton = LikeButton()
    
    private let dateField = EventInfoField()
    private let placeField = EventInfoField()
    private let priceField = EventInfoField()
    
    private let visitorsPreview = VisitorsPreview()
    
    private let descriptionTitle = UILabel()
    private let descriptionText = UILabel()
    
    private let organizerInfo = EventOrganizerInfo()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with event: Event) {
        titleLabel.text = event.title
        
        //dateField.configure(with: EventInfoFieldItem(title: <#T##String#>, subtitle: <#T##String?#>, image: <#T##UIImage#>))
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        addSubview(scroll)
        
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        contentStack.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 20, right: 16)
        contentStack.isLayoutMarginsRelativeArrangement = true
        scroll.addSubview(contentStack)
        
        topContainer.addSubview(titleLabel)
        topContainer.addSubview(likeButton)
        contentStack.addArrangedSubview(topContainer)
        contentStack.setCustomSpacing(20, after: topContainer)
        
        contentStack.addArrangedSubview(dateField)
        contentStack.setCustomSpacing(16, after: dateField)
        contentStack.addArrangedSubview(placeField)
        contentStack.setCustomSpacing(16, after: placeField)
        contentStack.addArrangedSubview(priceField)
        contentStack.setCustomSpacing(20, after: priceField)
        
        contentStack.addArrangedSubview(visitorsPreview)
        contentStack.setCustomSpacing(20, after: visitorsPreview)
        
        descriptionTitle.font = .h2
        descriptionTitle.textColor = Asset.Colors.black.color
        contentStack.addArrangedSubview(descriptionTitle)
        contentStack.setCustomSpacing(8, after: descriptionTitle)
        
        descriptionText.font = .p1
        descriptionText.textColor = Asset.Colors.black.color
        descriptionText.numberOfLines = 0
        descriptionText.lineBreakMode = .byWordWrapping
        contentStack.addArrangedSubview(descriptionText)
        contentStack.setCustomSpacing(20, after: descriptionText)
        
        contentStack.addArrangedSubview(organizerInfo)
    }
    
    private func setConstraints() {
        scroll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.trailing.equalTo(likeButton.snp.leading).offset(-16)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
