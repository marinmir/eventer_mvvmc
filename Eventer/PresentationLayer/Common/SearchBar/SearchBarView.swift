//
//  SearchBarView.swift
//  Eventer
//
//  Created by Ярослав Магин on 09.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import RxCocoa
import RxSwift
import UIKit

final class SearchBarView: UIView {
    // MARK: - Public properties
    
    var searchTextChanged: Driver<String> {
        return searchField.rx.text.orEmpty.asDriver()
    }
    
    var didTapFilters: Signal<Void> {
        return filtersButton.rx.controlEvent(.touchUpInside).asSignal()
    }
    
    // MARK: - Private properties
    private let glassImageView = UIImageView(image: Asset.UIKit.searchGlass.image)
    private let searchField = UITextField(frame: .zero)
    private let filtersButton = UIButton(frame: .zero)

    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupViews() {
        backgroundColor = .white

        addSubview(glassImageView)
        
        searchField.placeholder = L10n.Search.placeholder
        searchField.tintColor = Asset.Colors.darkViolet.color
        addSubview(searchField)

        addSubview(filtersButton)
    }

    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }

        glassImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.bottom.top.equalToSuperview()
        }
        
        filtersButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.bottom.top.equalToSuperview()
        }

        searchField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(glassImageView.snp.trailing)
            make.trailing.equalTo(filtersButton.snp.leading)
        }
    }
}
