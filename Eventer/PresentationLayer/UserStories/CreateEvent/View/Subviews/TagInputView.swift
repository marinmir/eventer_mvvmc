//
//  TagInputView.swift
//  Eventer
//
//  Created by Ярослав Магин on 23.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import UIKit

class TagsInputView: UIView {
    // MARK: - Properties
    
    var didToggleTag: ((TagViewModel) -> Void)?
    
    // MARK: - Private properties
    private var tags: [TagViewModel] = []
    
    private let tagsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let tagContentAdditionalSpace: CGFloat = 63
    
    // MARK: - Public methods
    init() {
        super.init(frame: .zero)
        
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setTags(_ tags: [TagViewModel]) {
        self.tags = tags
        tagsCollectionView.reloadData()
    }
    
    // MARK: - Private methods
    private func setAppearance() {
        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.backgroundColor = .white
        tagsCollectionView.register(TagCollectionCell.self, forCellWithReuseIdentifier: TagCollectionCell.cellReuseIdentifier)
        addSubview(tagsCollectionView)
        
        NSLayoutConstraint.activate([
            tagsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            tagsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TagsInputView: UICollectionViewDelegate, UICollectionViewDataSource {
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
        didToggleTag?(tags[indexPath.row])
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TagsInputView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = tags[indexPath.row]
        let itemSize = item.tag.name.size(withAttributes: [
            .font: UIFont.boldSystemFont(ofSize: 20)
        ])
        let size =  CGSize(width: itemSize.width + tagContentAdditionalSpace, height: itemSize.height + 20)
        return size
    }
    
}
