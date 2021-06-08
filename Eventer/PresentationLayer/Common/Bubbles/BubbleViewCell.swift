//
//  BubbleView.swift
//  Eventer
//
//  Created by Ярослав Магин on 03.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import UIKit

final class BubbleViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: BubbleViewCell.self)
    
    private let imageView = UIImageView()
    private var image: UIImage?
    private var selectedImage: UIImage?
    private let nameLabel = UILabel()
    
    private let imageViewSide: CGFloat = 20
    private let contentOffset: CGFloat = 16
    private var isSelectedState: Bool = false {
        didSet {
            if isSelectedState {
                setSelected()
            } else {
                setDeselected()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: BubbleViewModel) {
        nameLabel.text = viewModel.text
        image = viewModel.image
        selectedImage = viewModel.selectedImage
        isSelectedState = viewModel.isSelected
    }
    
    func toggle() {
        isSelectedState.toggle()
    }
    
    private func setupViews() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.isUserInteractionEnabled = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.sizeToFit()
        contentView.addSubview(nameLabel)        
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(contentOffset)
            make.width.equalTo(imageViewSide)
            make.height.equalTo(imageViewSide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-contentOffset)
            make.height.equalTo(28)
        }
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
