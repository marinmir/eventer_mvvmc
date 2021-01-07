//
//  DateView.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 30.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class DateView: UIView {
    // MARK: - Properties
    private let dayLabel = UILabel()
    private let monthLabel = UILabel()

    private let selfSide: CGFloat = 50
    private let sideOffset: CGFloat = 4

    // MARK: - Public methods
    func configure(dateTime: Date) {
        layer.cornerRadius = 9
        backgroundColor = .white
        layer.shadowColor = Asset.Colors.shadow.color.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 5)

        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        let day = String(Calendar.current.component(.day, from: dateTime))
        dayLabel.text = day
        dayLabel.textColor = Asset.Colors.darkViolet.color
        dayLabel.textAlignment = .center
        dayLabel.font = .boldSystemFont(ofSize: 20)
        dayLabel.adjustsFontSizeToFitWidth = true
        addSubview(dayLabel)

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        let month = CustomDateFormatter.getShortMonthName(from: dateTime)
        monthLabel.text = month
        monthLabel.textColor = .black
        monthLabel.textAlignment = .center
        monthLabel.font = .systemFont(ofSize: 14)
        monthLabel.adjustsFontSizeToFitWidth = true
        addSubview(monthLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: selfSide),
            heightAnchor.constraint(equalToConstant: selfSide),

            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: sideOffset),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideOffset),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideOffset),
            dayLabel.heightAnchor.constraint(equalToConstant: 25),

            monthLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: -sideOffset/2),
            monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sideOffset),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideOffset),
            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideOffset)
        ])
    }

}
