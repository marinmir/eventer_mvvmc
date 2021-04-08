//
//  EventsServiceImpl.swift
//  Eventer
//
//  Created by Ярослав Магин on 23.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import RxSwift

class EventsServiceImpl: EventsService {
    func loadAllEvents() -> Single<[EventType : [Event]]> {
        return Single.create { single in
            
            let events: [EventType: [Event]] = [
                EventType.promoted: [
                    Event(id: Date(), title: "Title1", place: "Place1", dateTime: Date(), cost: 100, description: "Desc1", titleImage: "", visitors: nil),
                    Event(id: Date(), title: "Title2", place: "Place2", dateTime: Date(), cost: 200, description: "Desc2", titleImage: "", visitors: nil),
                ],
                .popular: [
                    Event(id: Date(), title: "Title3", place: "Place3", dateTime: Date(), cost: 300, description: "Desc3", titleImage: "", visitors: nil),
                ],
                .thisWeek: [
                    Event(id: Date(), title: "Title4", place: "Place4", dateTime: Date(), cost: 400, description: "Desc4", titleImage: "", visitors: nil),
                ]
            ]
            
            single(.success(events))
            
            return Disposables.create()
        }
    }
    
    
}
