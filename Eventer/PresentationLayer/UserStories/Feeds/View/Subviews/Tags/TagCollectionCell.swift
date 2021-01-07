//
//  TagCollectionCell.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 10.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    static let cellReuseIdentifier = String(describing: TagCollectionCell.self)
    private let tagView = TagView()

    // MARK: - Public methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setApperance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tag: Tag) {
        tagView.configure(with: tag)
    }
    
    func toggle() {
        tagView.toggle()
    }
    
    // MARK: - Private methods
    private func setApperance() {
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.layer.cornerRadius = 20
        tagView.layer.masksToBounds = true
        clipsToBounds = false
        addSubview(tagView)
        
        NSLayoutConstraint.activate([
            tagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
