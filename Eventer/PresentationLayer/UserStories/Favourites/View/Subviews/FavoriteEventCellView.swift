//
//  FavoriteEventCellView.swift
//  Eventer
//
//  Created by Ярослав Магин on 18.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

class FavoriteEventCellView: UITableViewCell {
    // MARK: - Properties
    static let cellReuseIdentifier = String(describing: FavoriteEventCellView.self)
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let placeLabel = UILabel()
    private let costLabel = UILabel()

    private let titleImageSide: CGFloat = 90

    // MARK: - Public methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with event: EventCardViewModel) {
        //titleImageView.image = result.titleImage
        if let imageUrl = event.titleImage {
            titleImageView.loadImage(url: imageUrl)
        } else {
            titleImageView.image = Asset.eventDefault.image
        }
        
        titleLabel.text = event.title
        dateLabel.text = CustomDateFormatter.getEventDateString(from: event.pureDate)
        placeLabel.text = event.location
        costLabel.text = event.price
    }

    // MARK: - Private methods
    private func setAppearance() {
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.clipsToBounds = true
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.layer.cornerRadius = titleImageSide/2
        contentView.addSubview(titleImageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 1
        dateLabel.lineBreakMode = .byTruncatingTail
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textAlignment = .left
        dateLabel.textColor = .gray
        contentView.addSubview(dateLabel)

        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.numberOfLines = 1
        placeLabel.lineBreakMode = .byTruncatingTail
        placeLabel.font = .systemFont(ofSize: 16)
        placeLabel.textAlignment = .left
        placeLabel.textColor = .gray
        contentView.addSubview(placeLabel)

        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.numberOfLines = 1
        costLabel.lineBreakMode = .byTruncatingTail
        costLabel.font = .systemFont(ofSize: 16)
        costLabel.textAlignment = .left
        costLabel.textColor = .gray
        contentView.addSubview(costLabel)

        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleImageView.heightAnchor.constraint(equalToConstant: titleImageSide),
            titleImageView.widthAnchor.constraint(equalToConstant: titleImageSide),

            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor, constant: -28),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 44),

            costLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 8),
            costLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor),
            costLabel.heightAnchor.constraint(equalToConstant: 18),
            costLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),

            placeLabel.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 2),
            placeLabel.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
            placeLabel.heightAnchor.constraint(equalToConstant: 18),
            placeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),

            dateLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 8),
            dateLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor, constant: 28),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}
