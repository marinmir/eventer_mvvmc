//
//  TagsCell.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 10.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class TagsCell: UITableViewCell {
    // MARK: - Properties
    static let cellReuseIdentifier = String(describing: TagsCell.self)
    
    private let tags = Tags.tags
    
    private let tagsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let tagContentAdditionalSpace: CGFloat = 63
    
    // MARK: - Public methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setAppearance() {
        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.backgroundColor = .white
        tagsCollectionView.register(TagCollectionCell.self, forCellWithReuseIdentifier: TagCollectionCell.cellReuseIdentifier)
        contentView.addSubview(tagsCollectionView)
        
        NSLayoutConstraint.activate([
            tagsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TagsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.cellReuseIdentifier, for: indexPath) as? TagCollectionCell
            else {
                fatalError("Unable to dequeue cell with identifier \(TagCollectionCell.cellReuseIdentifier)")
        }
        
        cell.configure(with: tags[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionCell else { return }
        cell.toggle()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TagsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = tags[indexPath.row]
        let itemSize = item.name.size(withAttributes: [
            .font : UIFont.boldSystemFont(ofSize: 20)
        ])
        let size =  CGSize(width: itemSize.width + tagContentAdditionalSpace, height: itemSize.height + 20)
        return size
    }
    
}
