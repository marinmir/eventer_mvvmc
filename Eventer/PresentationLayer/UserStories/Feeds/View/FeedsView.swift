//
//  FeedsView.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxSwift
import UIKit

final class FeedsView: UIView {

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: FeedsViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }
}

//import UIKit
//
//class FeedsView: UIView {
//    // MARK: - Properties
//    weak var output: FeedsRepresentingOutput? {
//        didSet {
//            eventsList.dataSource = output
//            eventsList.delegate = output
//        }
//    }
//
//    let eventsList = UITableView(frame: .zero, style: .grouped)
//    private let refreshControl = UIRefreshControl()
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
//    func stopRefreshingIfNeeded() {
//        if refreshControl.isRefreshing {
//            refreshControl.endRefreshing()
//        }
//    }
//
//    // MARK: - Private methods
//    private func setAppearance() {
//        backgroundColor = .white
//
//        eventsList.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(refreshEvents), for: .valueChanged)
//        refreshControl.tintColor = .lightLavender
//        refreshControl.attributedTitle = NSAttributedString(string: "Getting new events...",
//                                                            attributes: [.foregroundColor: UIColor.darkViolet])
//
//        eventsList.translatesAutoresizingMaskIntoConstraints = false
//        eventsList.backgroundColor = .white
//        eventsList.separatorStyle = .none
//        eventsList.allowsSelection = false
//        eventsList.register(EventListCell.self, forCellReuseIdentifier: EventListCell.cellReuseIdentifier)
//        eventsList.register(TagsCell.self, forCellReuseIdentifier: TagsCell.cellReuseIdentifier)
//        addSubview(eventsList)
//
//        NSLayoutConstraint.activate([
//            eventsList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            eventsList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            eventsList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            eventsList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//
//    // MARK: - Private methods
//    @objc private func refreshEvents() {
//        output?.onRefresh()
//    }
//
//}

