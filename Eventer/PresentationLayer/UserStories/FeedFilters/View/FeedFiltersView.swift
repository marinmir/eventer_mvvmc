//
//  FeedFiltersView.swift
//  Eventer
//
//  Created by Ярослав Магин on 01/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class FeedFiltersView: UIView {

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

    private let resetButton = UIButton(frame: .zero)
    private let applyButton = UIButton(frame: .zero)
    private let tableView = UITableView(frame: .zero)
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

    func refresh() {
        tableView.reloadData()
    }
    
    func bind(to viewModel: FeedFiltersViewModelBindable) {
        applyButton.rx.tap.bind(to: viewModel.didTapApply).disposed(by: disposeBag)
        resetButton.rx.tap.bind(to: viewModel.didTapReset).disposed(by: disposeBag)
    }

    // MARK: - Private methods

    private func setupViews() {
        backgroundColor = Asset.Colors.white.color
        
        tableView.separatorStyle = .none
        addSubview(tableView)
        
        applyButton.setTitle(L10n.Filter.apply, for: .normal)
        applyButton.setTitleColor(Asset.Colors.white.color, for: .normal)
        applyButton.backgroundColor = Asset.Colors.darkViolet.color
        applyButton.layer.masksToBounds = true
        applyButton.layer.cornerRadius = 16
        addSubview(applyButton)
        
        resetButton.setTitle(L10n.Filter.reset, for: .normal)
        resetButton.setTitleColor(Asset.Colors.darkViolet.color, for: .normal)
        resetButton.backgroundColor = Asset.Colors.white.color
        addSubview(resetButton)
    }

    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        applyButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(150)
            make.trailing.bottom.equalToSuperview().inset(24)
        }
        
        resetButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(150)
            make.leading.bottom.equalToSuperview().inset(24)
        }
    }
}
