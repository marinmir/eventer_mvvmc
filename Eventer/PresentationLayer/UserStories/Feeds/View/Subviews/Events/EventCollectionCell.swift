//
//  EventCollectionCell.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 26.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class EventCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    static let cellReuseIdentifier = String(describing: EventCollectionCell.self)
    private let eventCard = EventCardView()
    
    private let shadowOffset = 5

    // MARK: - Public methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setApperance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with event: Event) {
        eventCard.configure(event)
    }
    
    // MARK: - Private methods
    private func setApperance() {
        layer.shadowColor = Asset.Colors.shadow.color.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
        layer.masksToBounds = false

        eventCard.translatesAutoresizingMaskIntoConstraints = false
        eventCard.layer.masksToBounds = true
        contentView.addSubview(eventCard)
        
        NSLayoutConstraint.activate([
            eventCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventCard.topAnchor.constraint(equalTo: topAnchor),
            eventCard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
