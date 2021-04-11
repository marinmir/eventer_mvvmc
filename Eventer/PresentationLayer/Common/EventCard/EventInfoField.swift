//
//  EventInfoField.swift
//  Eventer
//
//  Created by Ярослав Магин on 12.04.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

struct EventInfoFieldItem {
    let title: String
    let subtitle: String?
    let image: UIImage
}

final class EventInfoField: UIView {
    // MARK: - Private properties
    
    private let labelsStack = UIStackView()
    private let iconView = UIImageView()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public properties
    
    func configure(with item: EventInfoFieldItem) {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = Asset.Colors.black.color
        titleLabel.text = item.title
        labelsStack.addArrangedSubview(titleLabel)
        
        if let subtitle = item.subtitle {
            let subtitleLabel = UILabel()
            subtitleLabel.font = .systemFont(ofSize: 12)
            subtitleLabel.textColor = Asset.Colors.gray.color
            subtitleLabel.text = subtitle
            labelsStack.addArrangedSubview(subtitleLabel)
        }
        
        iconView.image = item.image
    }
    
    // MARK: - Private properties
    
    private func setupViews() {
        backgroundColor = Asset.Colors.white.color
        
        labelsStack.axis = .vertical
        labelsStack.distribution = .fill
        labelsStack.alignment = .leading
        addSubview(labelsStack)
        
        addSubview(iconView)
    }
    
    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(24)
        }
        
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.leading.equalToSuperview()
        }
        
        labelsStack.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(16)
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
