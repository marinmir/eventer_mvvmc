//
//  EventsListViewController.swift
//  Eventer
//
//  Created by Yaroslav Magin on 06/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class EventsListViewController: UIViewController {

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let viewModel: EventsListViewModelBindable
    private var events: [EventCardViewModel] = []

    // MARK: - Initializers

    init(viewModel: EventsListViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        super.loadView()

        let view = EventsListView()
        view.bind(to: viewModel)

        self.view = view
        
        view.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.events.drive(onNext: { events in
            self.events = events
            
            (self.view as? EventsListView)?.reload()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
    }
}

extension EventsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.cellReuseIdentifier, for: indexPath) as? EventCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: events[indexPath.row])
        
        return cell
    }
    
    
}
