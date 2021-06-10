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
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setBackgroundImage(Asset.UIKit.share.image, for: .normal)
        
        return button
    }()
    
    private let participateButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitleColor(Asset.Colors.white.color, for: .normal)
        button.backgroundColor = Asset.Colors.darkViolet.color
        button.setTitle(L10n.Event.participate, for: .normal)
        button.setTitle(L10n.Event.notParticipate, for: .selected)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.tintColor = .clear
        
        return button
    }()
    
    private let dateField = EventInfoField()
    private let placeField = EventInfoField()
    private let priceField = EventInfoField()
    
    private let visitorsPreview = VisitorsPreview()
    
    private let descriptionTitle = UILabel()
    private let descriptionText = UILabel()
    
    private let organizerInfo = EventOrganizerInfo()
    private weak var event: EventCardViewModel?
    
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
    
    func configure(with event: EventCardViewModel) {
        self.event = event
        titleLabel.text = event.title
        
        dateField.configure(with:
                                EventInfoFieldItem(
                                    title: event.date,
                                    subtitle: "",
                                    image: Asset.UIKit.Event.calendar.image
                                )
        )
        
        placeField.configure(with:
                                EventInfoFieldItem(
                                    title: event.location,
                                    subtitle: "",
                                    image: Asset.UIKit.Event.compass.image
                                )
        )
        
        priceField.configure(with:
                                EventInfoFieldItem(
                                    title: event.price,
                                    subtitle: "",
                                    image: Asset.UIKit.Event.ticket.image
                                )
        )
        
        if let visitors = event.visitorsPreview {
            visitorsPreview.configure(visitors: visitors)
        }
        
        descriptionText.text = event.eventDescription
        
        likeButton.isSelected = event.isFavorite
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        backgroundColor = Asset.Colors.white.color
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        
        addSubview(scroll)
        
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        contentStack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 20, right: 16)
        contentStack.isLayoutMarginsRelativeArrangement = true
        scroll.addSubview(contentStack)
        
        titleLabel.font = .h1
        titleLabel.textColor = Asset.Colors.black.color
        
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        participateButton.addTarget(self, action: #selector(didTapParticipate), for: .touchUpInside)
        
        topContainer.addSubview(titleLabel)
        topContainer.addSubview(likeButton)
        topContainer.addSubview(shareButton)
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
        descriptionTitle.text = L10n.Event.about
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
        
        contentStack.addArrangedSubview(participateButton)
    }
    
    private func setConstraints() {
        scroll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        topContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.leading.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-32)
        }
        
        participateButton.snp.makeConstraints({ make in
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        })
        
        shareButton.snp.makeConstraints { make in
            make.trailing.equalTo(likeButton.snp.leading).offset(-16)
            make.centerY.equalTo(likeButton)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
    }
    
    @objc private func didTapLike() {
        likeButton.isSelected.toggle()
        event?.onTapLike()
    }
    
    @objc private func didTapParticipate() {
        participateButton.isSelected.toggle()
        event?.onTapParticipate()
    }
    
    @objc private func didTapShare() {
        let message = L10n.Event.share(titleLabel.text!)
        
        if let link = NSURL(string: "http://yoururl.com") {
            let objectsToShare: [Any] = [message, link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            window?.rootViewController!.present(activityVC, animated: true, completion: nil)
        }
    }
}
