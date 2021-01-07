//
//  VisitorsPreview.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 27.07.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class VisitorsPreview: UIStackView {
    // MARK: - Properties
    private let countLabel = UILabel()
    private var profileImagesURLs: [String] = []
    private let profilesStack = UIStackView()
    private let profileImageSide: CGFloat = 28

    // MARK: - Public methods
    func configure(visitors: Visitors) {
        profileImagesURLs = visitors.profileImages

        if visitors.visitorsCount > 0 {
           countLabel.text = "+\(visitors.visitorsCount)"
        }

        cleanStackView()

        let maxImagesCount = 4

        profileImagesURLs.prefix(maxImagesCount).forEach { url in
            let profileImageView = UIImageView()
            profileImageView.loadImage(url: url)
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profilesStack.addArrangedSubview(profileImageView)

            profileImageView.layer.cornerRadius = 14
            profileImageView.layer.masksToBounds = true

            profileImageView.layer.borderWidth = 2
            profileImageView.layer.borderColor = UIColor.white.cgColor

            NSLayoutConstraint.activate([
                profileImageView.widthAnchor.constraint(equalToConstant: profileImageSide),
                profileImageView.heightAnchor.constraint(equalToConstant: profileImageSide)
            ])
        }

        axis = .horizontal
        spacing = 2
        alignment = .center

        profilesStack.axis = .horizontal
        profilesStack.spacing = -10
        profilesStack.alignment = .center
        addArrangedSubview(profilesStack)

        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.textColor = .black
        countLabel.textAlignment = .left
        countLabel.font = .systemFont(ofSize: 10)
        addArrangedSubview(countLabel)
    }

    // MARK: - Private methods
    func cleanStackView() {
        let viewsInStack = profilesStack.arrangedSubviews

        viewsInStack.forEach { view in
            view.removeFromSuperview()
        }
    }

}
