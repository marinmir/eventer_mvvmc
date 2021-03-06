//
//  FavouritesViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol FavouritesViewModelInput {
    func onEventTapped(index: Int)
}

/// Describes view model's output streams needed to update UI
protocol FavouritesViewModelOutput {
    var events: Driver<[EventCardViewModel]> { get }
}

protocol FavouritesViewModelBindable: FavouritesViewModelInput & FavouritesViewModelOutput {}

final class FavouritesViewModel: FavouritesModuleInput & FavouritesModuleOutput {
    var onEventDetailsRequested: ((Event) -> Void)?
    
    private let disposeBag = DisposeBag()
    private let eventsRelay = BehaviorRelay<[EventCardViewModel]>(value: [])
    private let eventsService: EventsService
    
    init(eventsService: EventsService) {
        self.eventsService = eventsService
        
        eventsService.favoriteEvents
            .map({ array in
                return array.map {
                    EventCardViewModel(
                        event: $0,
                        isFavorite: eventsService.isFavorite($0),
                        didTapLike: eventsService.toggleFavorite,
                        didTapParticipate: eventsService.toggleEventParticipation) }
            }).bind(to: eventsRelay)
            .disposed(by: disposeBag)
    }
}

// MARK: - FavouritesViewModelBindable implementation

extension FavouritesViewModel: FavouritesViewModelBindable {
	// Describe all bindings here
    var events: Driver<[EventCardViewModel]> {
        return eventsRelay.asDriver()
    }
    
    func onEventTapped(index: Int) {
        onEventDetailsRequested?(eventsRelay.value[index].event)
    }
}
