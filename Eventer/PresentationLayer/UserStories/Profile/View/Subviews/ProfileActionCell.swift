//
//  ProfileActionCell.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import UIKit

final class ProfileActionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    
    private let primaryLabel = UILabel()
    private let detailsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ProfileActionCell.reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ProfileSectionItemViewModel) {
        switch item {
        case .plain(let text, let details):
            primaryLabel.text = text
            detailsLabel.text = details
        case .logout:
            primaryLabel.textColor = .red
            primaryLabel.text = L10n.Profile.logout
        }
    }
    
    private func setupViews() {
        primaryLabel.font = .h1NonBold
        primaryLabel.textColor = .black
        contentView.addSubview(primaryLabel)
        
        detailsLabel.font = .h1NonBold
        detailsLabel.textColor = .lightGray
        contentView.addSubview(detailsLabel)
    }
    
    private func setConstraints() {
        primaryLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(8)
        }
    }
}
