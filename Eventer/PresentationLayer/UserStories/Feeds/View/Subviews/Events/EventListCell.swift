//
//  EventListCell.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 26.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class EventListCell: UITableViewCell {
    // MARK: - Properties
    static let cellReuseIdentifier = String(describing: EventListCell.self)
    
    var didTapEvent: ((Event) -> Void)?
    
    // MARK: - Private properties
    private var events: [EventCardViewModel] = []
    
    private let eventsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 260, height: 230)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // MARK: - Public methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with events: [EventCardViewModel]) {
        self.events = events
        eventsCollectionView.reloadData()
    }
    
    // MARK: - Private methods
    private func setAppearance() {
        eventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.backgroundColor = .white
        eventsCollectionView.register(EventCollectionCell.self, forCellWithReuseIdentifier: EventCollectionCell.cellReuseIdentifier)
        contentView.addSubview(eventsCollectionView)
        
        NSLayoutConstraint.activate([
            eventsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension EventListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = eventsCollectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.cellReuseIdentifier, for: indexPath) as? EventCollectionCell
            else {
                fatalError("Unable to dequeue cell with identifier \(TagCollectionCell.cellReuseIdentifier)")
        }
        
        cell.configure(with: events[indexPath.row])
        cell.didTapCell = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.didTapEvent?(self.events[indexPath.row].event)
        }
        
        return cell
    }
}
