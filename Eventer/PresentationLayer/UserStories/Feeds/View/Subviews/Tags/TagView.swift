//
//  TagView.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 10.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class TagView: UIView {
    // MARK: - Properties
    private var imageView = UIImageView()
    private var image: UIImage?
    private var selectedImage: UIImage?
    private let nameLabel = UILabel()
    private var isSelected: Bool = false {
        didSet { isSelected ? setSelected() : setDeselected() }
    }
    
    private let imageViewSide: CGFloat = 20
    private let tagContentOffset: CGFloat = 16
    
    init() {
        super.init(frame: CGRect.zero)
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    func configure(with tag: TagViewModel) {
        image = tag.tag.image
        selectedImage = tag.tag.selectedImage
        nameLabel.text = tag.tag.name
        isSelected = tag.isSelected
    }
    
    func toggle() {
        isSelected.toggle()
    }
    
    // MARK: Private methods
    private func setAppearance() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.isUserInteractionEnabled = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.sizeToFit()
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: tagContentOffset),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSide),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSide),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -tagContentOffset),
            nameLabel.heightAnchor.constraint(equalToConstant: 28)
        ])

    }
    
    private func setSelected() {
        imageView.image = selectedImage
        backgroundColor = Asset.Colors.darkViolet.color
        nameLabel.textColor = .white
    }

    private func setDeselected() {
        imageView.image = image
        backgroundColor = Asset.Colors.lightLavender.color
        nameLabel.textColor = Asset.Colors.darkViolet.color
    }

}
