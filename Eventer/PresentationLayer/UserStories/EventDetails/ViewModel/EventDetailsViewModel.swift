//
//  EventDetailsViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 11/04/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol EventDetailsViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol EventDetailsViewModelOutput {
    var eventDetails: EventCardViewModel { get }
}

protocol EventDetailsViewModelBindable: EventDetailsViewModelInput & EventDetailsViewModelOutput {}

final class EventDetailsViewModel: EventDetailsModuleInput & EventDetailsModuleOutput {
    let eventDetails: EventCardViewModel
    
    private let disposeBag = DisposeBag()
    
    init(event: Event, eventsService: EventsService) {
        eventDetails = EventCardViewModel(
            event: event,
            isFavorite: eventsService.isFavorite(event),
            didTapLike: eventsService.toggleFavorite,
            didTapParticipate: eventsService.toggleEventParticipation
        )
    }
}

// MARK: - EventDetailsViewModelBindable implementation

extension EventDetailsViewModel: EventDetailsViewModelBindable {
	// Describe all bindings here
}
