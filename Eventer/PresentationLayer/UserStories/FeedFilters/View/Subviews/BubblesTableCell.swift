//
//  BubblesTableCell.swift
//  Eventer
//
//  Created by Ярослав Магин on 16.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

final class BubbleTableCell: UITableViewCell {
    static let reuseIdentifier = String(describing: BubbleTableCell.self)
    
    private let bubbles = BubblesCollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: BubbleTableCell.reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModels: [BubbleViewModel]) {
        bubbles.configure(with: viewModels)
    }
    
    private func setupViews() {
        contentView.addSubview(bubbles)
    }
    
    private func setConstraints() {
        bubbles.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
