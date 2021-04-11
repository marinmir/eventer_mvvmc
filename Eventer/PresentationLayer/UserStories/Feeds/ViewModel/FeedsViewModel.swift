//
//  FeedsViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol FeedsViewModelInput {
    var needRefresh: Binder<Void> { get }
    var openSearch: Binder<Void> { get }
}

/// Describes view model's output streams needed to update UI
protocol FeedsViewModelOutput {
    var tableSections: Driver<[FeedsSectionViewModel]> { get }
}

protocol FeedsViewModelBindable: FeedsViewModelInput & FeedsViewModelOutput {}

final class FeedsViewModel: FeedsModuleInput & FeedsModuleOutput {
    private let disposeBag = DisposeBag()
    private let needRefreshRelay = PublishRelay<Void>()
    private let tableSectionsRelay = BehaviorRelay<[FeedsSectionViewModel]>(value: [])
    private let openSearchRelay = PublishRelay<Void>()
    private let eventsService: EventsService
    
    init(eventsService: EventsService) {
        self.eventsService = eventsService
        
        needRefreshRelay
            .flatMapLatest({ self.eventsService.loadEvents() })
            .subscribe(onNext: { events in
                var sections = [FeedsSectionViewModel]()
                sections.append(.tagList(tags: Tags.tags))
                
                if let promotedEvents = events[.promoted] {
                    sections.append(.promotedEvents(promotedEvents))
                }
                if let popularEvents = events[.popular] {
                    sections.append(.popularEvents(popularEvents))
                }
                if let weekendEvents = events[.thisWeek] {
                    sections.append(.weekendEvents(weekendEvents))
                }
                self.tableSectionsRelay.accept(sections)
            }).disposed(by: disposeBag)
    }
}

// MARK: - FeedsViewModelBindable implementation

extension FeedsViewModel: FeedsViewModelBindable {
    var needRefresh: Binder<Void> {
        return Binder(needRefreshRelay) { $0.accept($1) }
    }
    
    var openSearch: Binder<Void> {
        return Binder(openSearchRelay) { $0.accept($1) }
    }
    
    var tableSections: Driver<[FeedsSectionViewModel]> {
        return tableSectionsRelay.asDriver()
    }
}
