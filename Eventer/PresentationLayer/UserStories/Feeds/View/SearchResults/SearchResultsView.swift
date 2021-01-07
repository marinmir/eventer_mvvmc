//
//  SearchResultsView.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 15.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

class SearchResultsView: UIView {
    // MARK: - Properties
    let resultsList = UITableView(frame: .zero, style: .plain)
    private let notFoundView = SearchResultsNotFoundView()
    weak var dataSource: UITableViewDataSource? {
        didSet { resultsList.dataSource = dataSource }
    }
    
    weak var delegate: UITableViewDelegate? {
        didSet { resultsList.delegate = delegate }
    }
    
    private let contentOffset: CGFloat = 15
    
    // MARK: - Public methods
    init() {
        super.init(frame: .zero)
        setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func reloadData() {
        resultsList.reloadData()
        
        notFoundView.isHidden = resultsList.numberOfRows(inSection: 0) != 0
    }
    
    // MARK: - Private methods
    private func setAppearance() {
        backgroundColor = .white
        
        resultsList.translatesAutoresizingMaskIntoConstraints = false
        resultsList.backgroundColor = .white
        resultsList.rowHeight = 100
        resultsList.separatorStyle = .none
        resultsList.allowsSelection = false
        resultsList.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.cellReuseIdentifier)
        addSubview(resultsList)
        
        notFoundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(notFoundView)
        
        NSLayoutConstraint.activate([
            resultsList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            resultsList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: contentOffset),
            resultsList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -contentOffset),
            resultsList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            notFoundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            notFoundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            notFoundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            notFoundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
