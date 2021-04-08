//
//  SearchResultsView.swift
//  Eventer
//
//  Created by Ярослав Магин on 09/03/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SearchResultsView: UIView {

    // MARK: - Private properties

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

    func bind(to viewModel: SearchResultsViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }

    // MARK: - Private methods

    private func setupViews() {

    }

    private func setConstraints() {

    }
}

//class SearchResultsView: UIView {
//    // MARK: - Properties
//    let resultsList = UITableView(frame: .zero, style: .plain)
//    private let notFoundView = SearchResultsNotFoundView()
//    weak var dataSource: UITableViewDataSource? {
//        didSet { resultsList.dataSource = dataSource }
//    }
//
//    weak var delegate: UITableViewDelegate? {
//        didSet { resultsList.delegate = delegate }
//    }
//
//    private let contentOffset: CGFloat = 15
//
//    // MARK: - Public methods
//    init() {
//        super.init(frame: .zero)
//        setAppearance()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func reloadData() {
//        resultsList.reloadData()
//
//        notFoundView.isHidden = resultsList.numberOfRows(inSection: 0) != 0
//    }
//
//    // MARK: - Private methods
//    private func setAppearance() {
//        backgroundColor = .white
//
//        resultsList.translatesAutoresizingMaskIntoConstraints = false
//        resultsList.backgroundColor = .white
//        resultsList.rowHeight = 100
//        resultsList.separatorStyle = .none
//        resultsList.allowsSelection = false
//        resultsList.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.cellReuseIdentifier)
//        addSubview(resultsList)
//
//        notFoundView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(notFoundView)
//
//        NSLayoutConstraint.activate([
//            resultsList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            resultsList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: contentOffset),
//            resultsList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -contentOffset),
//            resultsList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//
//            notFoundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            notFoundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            notFoundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            notFoundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//
//}
