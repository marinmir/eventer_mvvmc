//
//  FavouritesView.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit

final class FavouritesView: UIView {

    var dataSource: UITableViewDataSource? {
        get {
            return tableView.dataSource
        }
        
        set {
            tableView.dataSource = newValue
        }
    }
    
    var delegate: UITableViewDelegate? {
        get {
            return tableView.delegate
        }
        
        set {
            tableView.delegate = newValue
        }
    }
    
    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let tableView = UITableView(frame: .zero)
    private let titleLabel = UILabel()

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

    func refresh() {
        tableView.reloadData()
    }
    
    func bind(to viewModel: FavouritesViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }
    
    private func setupViews() {
        backgroundColor = Asset.Colors.white.color
        
        tableView.register(FavoriteEventCellView.self, forCellReuseIdentifier: FavoriteEventCellView.cellReuseIdentifier)
        addSubview(tableView)
        
        titleLabel.text = L10n.Favorites.title
        titleLabel.font = .h1
        titleLabel.textColor = Asset.Colors.black.color
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
