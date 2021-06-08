//
//  ProfileAvatarCell.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import UIKit

final class ProfileAvatarCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    
    private let avatarImage = UIImageView()
    private let starImage = UIImageView(image: Asset.UIKit.star.image)
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    
    private enum Constants {
        static let height: CGFloat = 120
        static let imageHeight: CGFloat = 80
        static let contentInset = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ProfileAvatarCell.reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with avatarViewModel: AvatarViewModel) {
        avatarImage.image = avatarViewModel.image
        nameLabel.text = avatarViewModel.name
        ratingLabel.text = L10n.Profile.Avatar.Rating.stars(Float(avatarViewModel.stars))
    }
    
    private func setupViews() {
        contentView.addSubview(avatarImage)
        
        nameLabel.font = .h1NonBold
        nameLabel.textColor = Asset.Colors.black.color
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(starImage)
        
        ratingLabel.font = .p1
        ratingLabel.textColor = Asset.Colors.black.color
        contentView.addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(Constants.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage)
            make.leading.equalTo(avatarImage.snp.trailing).offset(24)
            make.trailing.equalToSuperview()
        }
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalTo(avatarImage.snp.trailing).offset(24)
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImage.snp.trailing).offset(16)
            make.centerY.equalTo(starImage)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.imageHeight)
            make.leading.equalToSuperview().offset(Constants.contentInset.left)
            make.top.equalToSuperview().offset(Constants.contentInset.top)
        }
    }
}
