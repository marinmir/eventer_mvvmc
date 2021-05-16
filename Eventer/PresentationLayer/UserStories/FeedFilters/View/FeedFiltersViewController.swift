//
//  FeedFiltersViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 01/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class FeedFiltersViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: FeedFiltersViewModelBindable
    private let disposeBag = DisposeBag()
    private var sections: [FiltersSection] = []
    
    // MARK: - Initializers

    init(viewModel: FeedFiltersViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        let view = FeedFiltersView()
        view.bind(to: viewModel)

        self.view = view
        
        view.dataSource = self
        view.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackgroundTap)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.filtersSections.drive(onNext: { sections in
            self.sections = sections
            (self.view as? FeedFiltersView)?.refresh()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = L10n.Filter.title
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.onDisappear()
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
    }
    
    @objc private func onBackgroundTap() {
        view.endEditing(true)
    }
}

extension FeedFiltersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
            case .location(let bubbles):
                let cell = BubbleTableCell()
                cell.configure(with: bubbles)
                return cell
            case .date(let bubbles):
                let cell = BubbleTableCell()
                cell.configure(with: bubbles)
                return cell
            case .timeOfDay(let bubbles):
                let cell = BubbleTableCell()
                cell.configure(with: bubbles)
                return cell
            case .price:
                let cell = PriceFilterTableCell()
                cell.configure(with: sections[indexPath.section])
                return cell
        }
    }
}

extension FeedFiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = Asset.Colors.white.color
        label.font = .h1
        label.textColor = Asset.Colors.black.color
        
        switch sections[section] {
            case .date:
                label.text = L10n.Filter.Date.title
            case .location:
                label.text = L10n.Filter.Location.title
            case .timeOfDay:
                label.text = L10n.Filter.TimeOfDay.title
            case .price:
                label.text = L10n.Filter.Price.title
        }
        
        return label
    }
}
