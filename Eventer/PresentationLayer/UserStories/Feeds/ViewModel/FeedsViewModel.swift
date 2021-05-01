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
    
    func didToggleTag(_ tag: TagViewModel)
    func didTapEvent(_ event: Event)
    func didTapEvent(at index: Int, in section: Int)
}

/// Describes view model's output streams needed to update UI
protocol FeedsViewModelOutput {
    var tableSections: Driver<[FeedsSectionViewModel]> { get }
}

protocol FeedsViewModelBindable: FeedsViewModelInput & FeedsViewModelOutput {}

final class FeedsViewModel: FeedsModuleInput & FeedsModuleOutput {
    var onEventDetailsRequested: ((Event) -> Void)?
    
    private let disposeBag = DisposeBag()
    private let needRefreshRelay = PublishRelay<Void>()
    private let tableSectionsRelay = BehaviorRelay<[FeedsSectionViewModel]>(value: [])
    private let openSearchRelay = PublishRelay<Void>()
    private let eventsService: EventsService
    private let tagsViewModels: [TagViewModel]
    private var events: [EventType: [Event]] = [:]
    
    init(eventsService: EventsService) {
        self.eventsService = eventsService
        tagsViewModels = Tags.tags.map { TagViewModel(tag: $0) }
        
        needRefreshRelay
            .flatMapLatest({ self.eventsService.loadEvents() })
            .subscribe(onNext: { events in
                self.events = events
                var sections = [FeedsSectionViewModel]()
                sections.append(.tagList(tags: self.tagsViewModels))
                
                let selectedTagsIds = Set(self.tagsViewModels.filter({ $0.isSelected }).compactMap({ $0.tag.id }))
                
                if selectedTagsIds.isEmpty {
                    if let promotedEvents = events[.promoted] {
                        sections.append(.promotedEvents(promotedEvents))
                    }
                    if let popularEvents = events[.popular] {
                        sections.append(.popularEvents(popularEvents))
                    }
                    if let weekendEvents = events[.thisWeek] {
                        sections.append(.weekendEvents(weekendEvents))
                    }
                } else {
                    if let promotedEvents = events[.promoted] {
                        let filteredEvents = promotedEvents.filter {
                            $0.tags?.contains(where: { tag in
                                                selectedTagsIds.contains(tag) }) ?? false
                        }
                        
                        if !filteredEvents.isEmpty {
                            sections.append(.promotedEvents(filteredEvents))
                        }
                    }
                    if let popularEvents = events[.popular] {
                        let filteredEvents = popularEvents.filter {
                            $0.tags?.contains(where: { tag in
                                                selectedTagsIds.contains(tag) }) ?? false
                        }
                        
                        if !filteredEvents.isEmpty {
                            sections.append(.popularEvents(filteredEvents))
                        }
                    }
                    if let weekendEvents = events[.thisWeek] {
                        let filteredEvents = weekendEvents.filter {
                            $0.tags?.contains(where: { tag in
                                                selectedTagsIds.contains(tag) }) ?? false
                        }
                        
                        if !filteredEvents.isEmpty {
                            sections.append(.weekendEvents(filteredEvents))
                        }
                    }
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
    
    func didTapEvent(_ event: Event) {
        onEventDetailsRequested?(event)
    }
    
    func didToggleTag(_ tag: TagViewModel) {
        tag.isSelected.toggle()
        
        needRefreshRelay.accept(())
    }
    
    func didTapEvent(at index: Int, in section: Int) {
        let section = tableSectionsRelay.value[section]
        
        switch section {
            case .popularEvents(let events):
                onEventDetailsRequested?(events[index])
            case .promotedEvents(let events):
                onEventDetailsRequested?(events[index])
            case .weekendEvents(let events):
                onEventDetailsRequested?(events[index])
            default:
                break
        }
    }
}
