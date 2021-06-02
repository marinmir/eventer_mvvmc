//
//  ProfileView.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxSwift
import UIKit

final class ProfileView: UIView {

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

    private let tableView = UITableView(frame: .zero, style: .grouped)
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
        tableView.reloadData()
    }
    
    func bind(to viewModel: ProfileViewModelBindable) {
        
    }
    
    private func setupViews() {
        tableView.register(ProfileActionCell.self, forCellReuseIdentifier: ProfileActionCell.reuseIdentifier)
        tableView.register(ProfileAvatarCell.self, forCellReuseIdentifier: ProfileAvatarCell.reuseIdentifier)
        
        addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
