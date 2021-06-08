//
//  EventsListView.swift
//  Eventer
//
//  Created by Yaroslav Magin on 06/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class EventsListView: UIView {

    var dataSource: UICollectionViewDataSource? {
        get {
            return eventsCollection.dataSource
        }
        
        set {
            eventsCollection.dataSource = newValue
        }
    }
    
    var delegate: UICollectionViewDelegate? {
        get {
            return eventsCollection.delegate
        }
        
        set {
            eventsCollection.delegate = newValue
        }
    }
    
    // MARK: - Private properties

    private let eventsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 260, height: 230)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 15, bottom: 16, right: 15)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupViews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func reload() {
        eventsCollection.reloadData()
    }
    
    func bind(to viewModel: EventsListViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }

    // MARK: - Private methods

    private func setupViews() {
        eventsCollection.allowsSelection = true
        eventsCollection.backgroundColor = .white
        eventsCollection.register(EventCollectionCell.self, forCellWithReuseIdentifier: EventCollectionCell.cellReuseIdentifier)
        addSubview(eventsCollection)
    }

    private func setConstraints() {
        eventsCollection.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
