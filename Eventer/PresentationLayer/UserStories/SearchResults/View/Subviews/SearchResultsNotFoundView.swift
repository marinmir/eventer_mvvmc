//
//  SearchResultsNotFoundView.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 18.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class SearchResultsNotFoundView: UIView {
    // MARK: - Properties
    private let contentOffset: CGFloat = 25
    private let smileSide: CGFloat = 50

    // MARK: - Public methods
    init() {
        super.init(frame: CGRect.zero)

        setSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setSubviews() {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)

        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.text = NSLocalizedString("Sorry, not found", comment: "")
        message.textColor = Asset.Colors.darkViolet.color
        message.font = .systemFont(ofSize: 25)
        addSubview(message)

        let sadSmile = UIImageView(image: UIImage(named: "SadSmile"))
        sadSmile.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sadSmile)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            container.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),

            message.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -contentOffset),
            message.centerXAnchor.constraint(equalTo: centerXAnchor),

            sadSmile.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: contentOffset),
            sadSmile.centerXAnchor.constraint(equalTo: centerXAnchor),
            sadSmile.widthAnchor.constraint(equalToConstant: smileSide),
            sadSmile.heightAnchor.constraint(equalToConstant: smileSide)
        ])
    }
}
