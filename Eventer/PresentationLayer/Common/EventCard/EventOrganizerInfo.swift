//
//  EventOrganizerInfo.swift
//  Eventer
//
//  Created by Ярослав Магин on 12.04.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

final class EventOrganizerInfo: UIView {
    // MARK: - Private properties
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let organizerLabel = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public properties
    
    
    // MARK: - Private methods
    
    private func setupViews() {
        iconView.layer.masksToBounds = true
        layer.cornerRadius = 24
        addSubview(iconView)
        
        titleLabel.font = .p2
        titleLabel.textColor = Asset.Colors.black.color
        addSubview(titleLabel)
        
        organizerLabel.font = .p2
        organizerLabel.textColor = Asset.Colors.gray.color
        organizerLabel.text = L10n.Event.Details.organizer
        addSubview(organizerLabel)
    }
    
    private func setConstraints() {
        iconView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(16)
            make.top.trailing.equalToSuperview()
        }
        
        organizerLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.trailing.equalToSuperview()
        }
    }
}
