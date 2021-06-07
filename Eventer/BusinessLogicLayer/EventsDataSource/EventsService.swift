//
//  EventsDataSource.swift
//  Eventer
//
//  Created by Ярослав Магин on 09.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import RxSwift

protocol EventsService {
    var loadedEvents: Observable<[Event]> { get }
    var favoriteEvents: Observable<[Event]> { get }
    
    func createEvent(
        with title: String,
        image: UIImage,
        location: PickedPinViewModel,
        date: Date,
        cost: Double,
        tags: [String]
    ) -> Completable
    func loadEvents() -> Single<[EventType: [Event]]>
    func toggleFavorite(event: Event)
    func toggleEventParticipation(event: Event)
}
