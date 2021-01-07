//
//  FeedsSectionHeaderView.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 03.09.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class FeedsSectionHeaderView: UIView {
    // MARK: - Properties
    private let leading: CGFloat = 15
    private let font: CGFloat = 25
    
    // MARK: - Public methods
    init(title text: String, image img: UIImage? = nil) {
        super.init(frame: CGRect.zero)
        
        let titleLabel = UILabel()
        let imageView = UIImageView(image: img)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString(text, comment: "")
        titleLabel.font = .boldSystemFont(ofSize: font)
        addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.transform = imageView.transform.rotated(by: .pi/4)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: font),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
