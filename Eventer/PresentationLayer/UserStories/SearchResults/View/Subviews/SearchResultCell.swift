//
//  SearchResultCell.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 15.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

//class SearchResultCell: UITableViewCell {
//    // MARK: - Properties
//    static let cellReuseIdentifier = String(describing: SearchResultCell.self)
//    private let titleImageView = UIImageView()
//    private let titleLabel = UILabel()
//    private let dateLabel = UILabel()
//    private let placeLabel = UILabel()
//    private let costLabel = UILabel()
//    
//    private let titleImageSide: CGFloat = 90
//    
//    // MARK: - Public methods
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setAppearance()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with result: Event) {
//        //titleImageView.image = result.titleImage
//        titleLabel.text = result.title
//        dateLabel.text = CustomDateFormatter.getEventDateString(from: result.dateTime)
//        placeLabel.text = result.place
//        costLabel.text = String(result.cost)
//    }
//    
//    // MARK: - Private methods
//    private func setAppearance() {
//        titleImageView.translatesAutoresizingMaskIntoConstraints = false
//        titleImageView.clipsToBounds = true
//        titleImageView.contentMode = .scaleAspectFill
//        titleImageView.layer.cornerRadius = titleImageSide/2
//        contentView.addSubview(titleImageView)
//        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.numberOfLines = 1
//        titleLabel.lineBreakMode = .byTruncatingTail
//        titleLabel.font = .boldSystemFont(ofSize: 20)
//        titleLabel.textAlignment = .left
//        contentView.addSubview(titleLabel)
//        
//        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        dateLabel.numberOfLines = 1
//        dateLabel.lineBreakMode = .byTruncatingTail
//        dateLabel.font = .systemFont(ofSize: 16)
//        dateLabel.textAlignment = .left
//        dateLabel.textColor = .gray
//        contentView.addSubview(dateLabel)
//        
//        placeLabel.translatesAutoresizingMaskIntoConstraints = false
//        placeLabel.numberOfLines = 1
//        placeLabel.lineBreakMode = .byTruncatingTail
//        placeLabel.font = .systemFont(ofSize: 16)
//        placeLabel.textAlignment = .left
//        placeLabel.textColor = .gray
//        contentView.addSubview(placeLabel)
//        
//        costLabel.translatesAutoresizingMaskIntoConstraints = false
//        costLabel.numberOfLines = 1
//        costLabel.lineBreakMode = .byTruncatingTail
//        costLabel.font = .systemFont(ofSize: 16)
//        costLabel.textAlignment = .left
//        costLabel.textColor = .gray
//        contentView.addSubview(costLabel)
//        
//        NSLayoutConstraint.activate([
//            titleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleImageView.heightAnchor.constraint(equalToConstant: titleImageSide),
//            titleImageView.widthAnchor.constraint(equalToConstant: titleImageSide),
//            
//            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 8),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor, constant: -20),
//            titleLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            costLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 8),
//            costLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor),
//            costLabel.heightAnchor.constraint(equalToConstant: 18),
//            costLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
//            
//            placeLabel.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 2),
//            placeLabel.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
//            placeLabel.heightAnchor.constraint(equalToConstant: 18),
//            placeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
//            
//            dateLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 8),
//            dateLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor, constant: 18),
//            dateLabel.heightAnchor.constraint(equalToConstant: 18),
//            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//        ])
//    }
//    
//}
