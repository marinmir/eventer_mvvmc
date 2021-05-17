//
//  EventsServiceImpl.swift
//  Eventer
//
//  Created by Ярослав Магин on 23.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import RxSwift

class EventsServiceImpl: EventsService {
    private let database = Firestore.firestore()
    private let disposeBag = DisposeBag()
    private let loadedEventsObservable = BehaviorSubject<[Event]>(value: [])
    
    var loadedEvents: Observable<[Event]> {
        return loadedEventsObservable.asObservable()
    }
    
    func loadEvents() -> Single<[EventType: [Event]]> {
        return Single.create { single in
            
            Observable.zip(
                self.loadFirebaseEvents(for: "/popular").asObservable().materialize(),
                self.loadFirebaseEvents(for: "/promoted").asObservable().materialize(),
                self.loadFirebaseEvents(for: "/thisWeek").asObservable().materialize()
            ).subscribe(onNext: { popularEvents, promotedEvents, thisWeekEvents in
                var result: [EventType: [Event]] = [:]
                if let popularEvents = popularEvents.element {
                    result[.popular] = popularEvents
                }
                if let promotedEvents = promotedEvents.element {
                    result[.promoted] = promotedEvents
                }
                if let thisWeekEvents = thisWeekEvents.element {
                    result[.thisWeek] = thisWeekEvents
                }
                
                if !popularEvents.isCompleted && !promotedEvents.isCompleted && !thisWeekEvents.isCompleted {
                    self.loadedEventsObservable.onNext(
                        (popularEvents.element ?? []) +
                            (promotedEvents.element ?? []) +
                            (thisWeekEvents.element ?? [])
                    )
                }
                
                single(.success(result))
            }).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    private func loadFirebaseEvents(for path: String) -> Single<[Event]> {
        return Single.create { single in
            
            let docRef = self.database.collection(path)
            
            docRef.getDocuments { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    let events = querySnapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    single(.success(events))
                } else if let error = error {
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
