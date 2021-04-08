//
//  SearchResultsViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 09/03/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import UIKit

final class SearchResultsViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: SearchResultsViewModelBindable

    // MARK: - Initializers

    init(viewModel: SearchResultsViewModelBindable) {
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

        let view = SearchResultsView()
        view.bind(to: viewModel)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//class SearchResultsViewController: UIViewController {
//    // MARK: - Properties
//    private var results: [Event] = []
//
//    private var resultsView: SearchResultsView!
//
//    // MARK: Public methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func loadView() {
//        super.loadView()
//
//        resultsView = SearchResultsView()
//        resultsView.delegate = self
//        resultsView.dataSource = self
//
//        view = resultsView
//    }
//
//    func showResults(_ results: [Event]) {
//        self.results = results
//        resultsView.reloadData()
//    }
//}
//
//// MARK: - UITableViewDelegate, UITableViewDataSource
//extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return results.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: SearchResultCell.cellReuseIdentifier,
//                for: indexPath
//        ) as? SearchResultCell else {
//            fatalError("Unable to dequeue cell with identifier \(SearchResultCell.cellReuseIdentifier)")
//        }
//        cell.configure(with: results[indexPath.row])
//        return cell
//    }
//}
