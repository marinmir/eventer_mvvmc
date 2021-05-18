//
//  FavouritesViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class FavouritesViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: FavouritesViewModelBindable
    private let disposeBag = DisposeBag()
    private var events: [EventCardViewModel] = []
    
    // MARK: - Initializers

    init(viewModel: FavouritesViewModelBindable) {
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

        let view = FavouritesView()
        view.bind(to: viewModel)

        self.view = view
        
        view.dataSource = self
        view.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.events.drive(onNext: { events in
            self.events = events
            (self.view as? FavouritesView)?.refresh()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteEventCellView.cellReuseIdentifier, for: indexPath) as? FavoriteEventCellView else {
            return UITableViewCell()
        }
        
        cell.configure(with: events[indexPath.row])
        
        return cell
    }
}

extension FavouritesViewController: UITableViewDelegate {
    
}
