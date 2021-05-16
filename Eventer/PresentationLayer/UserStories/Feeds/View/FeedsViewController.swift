//
//  FeedsViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class FeedsViewController: UIViewController {
    // MARK: - Private properties

    private let viewModel: FeedsViewModelBindable
    private var searchResultsController = SearchResultsViewController(viewModel: SearchResultsViewModel())
    private lazy var searchController: UISearchController = UISearchController(searchResultsController: searchResultsController)
    
    private let disposeBag = DisposeBag()
    private var feedsSections: [FeedsSectionViewModel] = []
    
    // MARK: - Initializers

    init(viewModel: FeedsViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {

        let view = FeedsView()
        view.bind(to: viewModel)

        self.view = view
        
        view.eventsDataSource = self
        view.tableDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupFilter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        viewModel.tableSections.drive(onNext: { newSections in
            self.feedsSections = newSections
            (self.view as? FeedsView)?.refresh()
        }).disposed(by: disposeBag)
        
        viewModel.needRefresh.onNext(())
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    private func setupSearchController() {
        //searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = L10n.Search.placeholder
        //searchController.searchBar.delegate = self
        //searchController.delegate = self
        searchController.searchBar.tintColor = Asset.Colors.darkViolet.color
        
        searchController.searchBar.rx
            .text
            .orEmpty
            .asDriver()
            .debounce(.milliseconds(500))
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] query in
                //self.output.onSearchQueryChanged(for: query)
                print(query)
            }).disposed(by: disposeBag)
        
        navigationItem.titleView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func setupFilter() {
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(Asset.UIKit.filter.image, for: .bookmark, state: .normal)
        
        searchController.searchBar.delegate = self
    }
    
    private func didTapEvent(event: Event) {
        viewModel.didTapEvent(event)
    }
    
    private func didToggleTag(_ tag: TagViewModel) {
        viewModel.didToggleTag(tag)
    }
}

extension FeedsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch feedsSections[indexPath.section] {
            case .tagList(let tags):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TagsCell.cellReuseIdentifier, for: indexPath) as? TagsCell else {
                    return UITableViewCell()
                }
                
                cell.setTags(tags)
                cell.didToggleTag = didToggleTag
                
                return cell
            case .popularEvents(let popularEvents):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.cellReuseIdentifier, for: indexPath) as? EventListCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: popularEvents)
                cell.didTapEvent = didTapEvent
                
                return cell
            case .promotedEvents(let promotedEvents):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.cellReuseIdentifier, for: indexPath) as? EventListCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: promotedEvents)
                cell.didTapEvent = didTapEvent
                
                return cell
            case .weekendEvents(let weekendEvents):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.cellReuseIdentifier, for: indexPath) as? EventListCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: weekendEvents)
                cell.didTapEvent = didTapEvent
                
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapEvent(at: indexPath.row, in: indexPath.section)
    }
}

extension FeedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch feedsSections[section] {
            case .promotedEvents:
                return FeedsSectionHeaderView(title: L10n.Feeds.Sections.promoted, image: Asset.crown.image)
            case .popularEvents:
                return FeedsSectionHeaderView(title: L10n.Feeds.Sections.popular)
            case .weekendEvents:
                return FeedsSectionHeaderView(title: L10n.Feeds.Sections.thisWeekend)
            default:
                return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return CGFloat(60)
            default:
                return CGFloat(250)
        }
    }
}

// MARK: - UISearchBarDelegate
extension FeedsViewController: UISearchBarDelegate {
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didTapFilters()
    }

}

//import UIKit
//
//import RxCocoa
//import RxSwift
//
//class FeedsViewController: UIViewController {
//    // MARK: - Properties
//    var output: FeedsViewOutput!
//    
//    private var eventsGroups: [EventType: [Event]] = [:]
//    private var sectionsCount: Int { eventsGroups.count + 1 }
//    private var indicesMap: [Int: EventType] = [:]
//    private var searchResultsController = SearchResultsViewController()
//    private let disposeBag = DisposeBag()
//    
//    private var _view: FeedsView {
//        get {
//            return view as! FeedsView
//        }
//    }
//    
//    private lazy var searchController: UISearchController = UISearchController(searchResultsController: searchResultsController)
//    
//    // MARK: - Public Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        setupSearchController()
//        setupFilter()
//        
//        output.onViewDidLoad()
//    }
//    
//    
//    override func loadView() {
//        super.loadView()
//        
//        let feedsView = FeedsView()
//        feedsView.output = self
//        view = feedsView
//    }
//    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//          navigationController?.setNavigationBarHidden(true, animated: true)
//       } else {
//          navigationController?.setNavigationBarHidden(false, animated: true)
//       }
//    }
//    
//    // MARK: - Private methods
//    private func setupSearchController() {
//        //searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchBar.placeholder = NSLocalizedString("Search for...", comment: "")
//        searchController.searchBar.tintColor = .darkViolet
//
//        searchController.searchBar.rx
//            .text
//            .orEmpty
//            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .subscribe(onNext: { [unowned self] query in
//                self.output.onSearchQueryChanged(for: query)
//            })
//            .disposed(by: disposeBag)
//        
//        navigationItem.titleView = searchController.searchBar
//        
//        searchController.hidesNavigationBarDuringPresentation = false
//        definesPresentationContext = true
//    }
//    
//    private func setupFilter() {
//        searchController.searchBar.showsBookmarkButton = true
//        searchController.searchBar.setImage(UIImage(named: "Filter"), for: .bookmark, state: .normal)
//        
//        //searchController.searchBar.delegate = self
//    }
//    
//}
//
//// MARK: - FeedsViewInput
//extension FeedsViewController: FeedsViewInput {
//    func showSearchResults(_ results: [Event]) {
//        searchResultsController.showResults(results)
//    }
//    
//    func showEvents(_ events: [EventType:[Event]]) {
//        updateTableMetadata(events)
//        
//        _view.eventsList.reloadData()
//        _view.stopRefreshingIfNeeded()
//    }
//    
//    private func updateTableMetadata(_ events: [EventType: [Event]]) {
//        eventsGroups = events
//        
//        if (events[.promoted] != nil) {
//            indicesMap[1] = .promoted
//            if (events[.popular] != nil) {
//                indicesMap[2] = .popular
//                if (events[.thisWeek] != nil) {
//                    indicesMap[3] = .thisWeek
//                }
//            }
//            else if (events[.thisWeek] != nil) {
//                indicesMap[2] = .thisWeek
//            }
//        }
//        else if (events[.popular] != nil) {
//            indicesMap[1] = .popular
//            if (events[.thisWeek] != nil) {
//                indicesMap[2] = .thisWeek
//            }
//        }
//        else if (events[.thisWeek] != nil) {
//            indicesMap[1] = .thisWeek
//        }
//    }
//    
//}
//
//// MARK: - UITableViewDelegate, UITableViewDataSource
//extension FeedsViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionsCount
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: TagsCell.cellReuseIdentifier, for: indexPath) as? TagsCell else {
//                fatalError("Unable to dequeue cell with identifier \(TagsCell.cellReuseIdentifier)")
//            }
//            return cell
//        default:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.cellReuseIdentifier, for: indexPath) as? EventListCell else {
//                fatalError("Unable to dequeue cell with identifier \(EventListCell.cellReuseIdentifier)")
//            }
//            
//            if let categoryEvents = eventsGroups[indicesMap[indexPath.section]!] {
//                cell.configure(with: categoryEvents)
//            }
//            
//            return cell
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch indicesMap[section] {
//        case .promoted:
//            return FeedsSectionHeaderView(title: "Promoted", image: UIImage(named: "Crown"))
//        case .popular:
//            return FeedsSectionHeaderView(title: "Popular")
//        case .thisWeek:
//            return FeedsSectionHeaderView(title: "This week")
//        default:
//            return nil
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return CGFloat(60)
//        default:
//            return CGFloat(250)
//        }
//    }
//    
//}
//
////// MARK: - UISearchBarDelegate
////extension FeedsViewController: UISearchBarDelegate {
////    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
////        // TODO: open screen with filters
////    }
////
////}
//
//// MARK: - FeedsRepreswntingOutput
//extension FeedsViewController: FeedsRepresentingOutput {
//    func onRefresh() {
//        output.onRefreshFeeds()
//    }
//    
//}
