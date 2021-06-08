//
//  BubblesCollectionView.swift
//  Eventer
//
//  Created by Ярослав Магин on 03.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import UIKit

final class BubblesCollectionView: UIView {
    // MARK: - Properties
    
    var didToggleBubble: ((BubbleViewModel) -> Void)?
    
    private let bubbleContentAdditionalSpace: CGFloat = 63
    private var bubbles: [BubbleViewModel] = []
    private let bubblesCollection: UICollectionView
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        bubblesCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModels: [BubbleViewModel]) {
        bubbles = viewModels
        bubblesCollection.reloadData()
    }
    
    private func setupViews() {
        backgroundColor = Asset.Colors.white.color
        bubblesCollection.backgroundColor = Asset.Colors.white.color
        
        bubblesCollection.dataSource = self
        bubblesCollection.delegate = self
        bubblesCollection.allowsSelection = true
        bubblesCollection.register(BubbleViewCell.self, forCellWithReuseIdentifier: BubbleViewCell.reuseIdentifier)
        addSubview(bubblesCollection)
    }
    
    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(78)
        }
        
        bubblesCollection.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BubblesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bubbles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BubbleViewCell.reuseIdentifier, for: indexPath) as? BubbleViewCell
            else {
                fatalError("Unable to dequeue cell with identifier \(BubbleViewCell.reuseIdentifier)")
        }
        
        cell.configure(with: bubbles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BubbleViewCell else { return }
        cell.toggle()
        didToggleBubble?(bubbles[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BubblesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = bubbles[indexPath.row]
        let itemSize = item.text.size(withAttributes: [
            .font: UIFont.boldSystemFont(ofSize: 20)
        ])
        let size =  CGSize(width: itemSize.width + bubbleContentAdditionalSpace, height: itemSize.height + 20)
        return size
    }
    
}
