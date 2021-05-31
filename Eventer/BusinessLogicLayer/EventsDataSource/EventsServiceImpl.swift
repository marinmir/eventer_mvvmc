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
    private let storage = Storage.storage()
    private let disposeBag = DisposeBag()
    private let loadedEventsObservable = BehaviorSubject<[Event]>(value: [])
    private let favoriteEventsObservable = BehaviorSubject<[Event]>(value: [])
    
    var loadedEvents: Observable<[Event]> {
        return loadedEventsObservable.asObservable()
    }
    
    var favoriteEvents: Observable<[Event]> {
        return favoriteEventsObservable.asObservable()
    }
    
    init() {
        database.collection("/users").document("1").collection("favorites").addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                let events = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                self.favoriteEventsObservable.onNext(events)
            }
        }
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
    
    func createEvent(
        with title: String,
        image: UIImage,
        location: PickedPinViewModel,
        date: Date,
        cost: Double,
        tags: [String]
    ) -> Completable {
        return Completable.create { completable in
            let uuid = UUID().uuidString
            let imagePath = "/events/\(uuid)/\(uuid).png"
            
            if let imageData = image.pngData() {
                let ref = self.storage.reference()
                let imageRef = ref.child(imagePath)
                imageRef.putData(imageData)
            }
            
            let event = Event(
                id: uuid,
                title: title,
                place: location.address,
                dateTime: date,
                cost: cost,
                description: "",
                titleImage: imagePath,
                visitors: nil,
                tags: tags,
                location: EventLocation(
                    lat: location.location.coordinate.latitude,
                    long: location.location.coordinate.longitude
                )
            )
            let collectionRef = self.database.collection("/users").document("1").collection("my")
            
            _ = try? collectionRef.document(uuid).setData(from: event) { error in
                if error == nil {
                    completable(.completed)
                } else {
                    completable(.error(error!))
                }
            }
            return Disposables.create()
        }
    }
    
    func toggleFavorite(event: Event) {
        let docRef = database.collection("/users").document("1").collection("favorites").document("\(event.id ?? "")")
        
        docRef.getDocument { querySnapshot, error in
            if let querySnapshot = querySnapshot, querySnapshot.exists {
                docRef.delete()
            } else {
                try? self.database.collection("/users").document("1").collection("favorites").document("\(event.id ?? "")").setData(from: event)
            }
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
