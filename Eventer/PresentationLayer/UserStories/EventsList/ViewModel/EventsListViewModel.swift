//
//  EventsListViewModel.swift
//  Eventer
//
//  Created by Yaroslav Magin on 06/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol EventsListViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol EventsListViewModelOutput {
    var events: Driver<[EventCardViewModel]> { get }
}

protocol EventsListViewModelBindable: EventsListViewModelInput & EventsListViewModelOutput {}

final class EventsListViewModel: EventsListModuleInput & EventsListModuleOutput {
    private let disposeBag = DisposeBag()
    private let eventsRelay: BehaviorRelay<[EventCardViewModel]>
    private let eventsService: EventsService
    
    init(eventsList: [Event], eventsService: EventsService) {
        self.eventsService = eventsService
        eventsRelay = BehaviorRelay(value: eventsList.map {
                                        EventCardViewModel(
                                            event: $0,
                                            didTapLike: eventsService.toggleFavorite,
                                            didTapParticipate: eventsService.toggleEventParticipation) })
    }
}

// MARK: - EventsListViewModelBindable implementation

extension EventsListViewModel: EventsListViewModelBindable {
    var events: Driver<[EventCardViewModel]> {
        return eventsRelay.asDriver()
    }
}
