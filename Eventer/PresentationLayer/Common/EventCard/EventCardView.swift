//
//  EventCardView.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 20.07.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EventCardView: UIView {
    // MARK: - Properties
    private let titleImageView = UIImageView()
    private let dateView = DateView()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        return titleLabel
    }()

    private let placeLabel = UILabel()
    private let visitorsPreview = VisitorsPreview()
    private let likeButton = LikeButton()
    
    private let disposeBag = DisposeBag()
    private let sideOffset: CGFloat = 10

    // MARK: - Public methods
    init() {
        super.init(frame: CGRect.zero)
        setAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ event: EventCardViewModel) {
        if let titleImage = event.titleImage {
            titleImageView.loadImage(url: titleImage)
        } else {
            titleImageView.image = Asset.eventDefault.image
        }

        titleLabel.text = event.title
        
        placeLabel.text = "\(event.location), \(event.time)"
        dateView.configure(dateTime: event.pureDate)
        
        if let visitors = event.visitorsPreview {
            visitorsPreview.configure(visitors: visitors)
        }
        
        likeButton.didTap.emit(onNext: {
            event.onTapLike()
        }).disposed(by: disposeBag)
    }

    // MARK: - Private methods
    private func setAppearance() {
        layer.cornerRadius = 20
        backgroundColor = .white

        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.clipsToBounds = true
        titleImageView.contentMode = .scaleAspectFill
        addSubview(titleImageView)

        dateView.translatesAutoresizingMaskIntoConstraints = false
        bringSubviewToFront(dateView)
        addSubview(dateView)

        addSubview(titleLabel)

        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.numberOfLines = 1
        placeLabel.lineBreakMode = .byTruncatingTail
        placeLabel.font = .systemFont(ofSize: 14)
        placeLabel.textAlignment = .left
        placeLabel.textColor = .gray
        addSubview(placeLabel)

        visitorsPreview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(visitorsPreview)

        likeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleImageView.topAnchor.constraint(equalTo: topAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: sideOffset),

            dateView.centerYAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: -sideOffset),
            dateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),

            titleLabel.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            placeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            placeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideOffset),
            placeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideOffset),
            placeLabel.heightAnchor.constraint(equalToConstant: 15),

            visitorsPreview.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 4),
            visitorsPreview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideOffset),
            visitorsPreview.trailingAnchor.constraint(equalTo: centerXAnchor),
            visitorsPreview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sideOffset),

            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sideOffset),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideOffset)
        ])
    }

    private func didTapLike() {
        likeButton.isSelected.toggle()
    }
    
}
