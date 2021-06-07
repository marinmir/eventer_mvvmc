//
//  ProfileManager.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import RxCocoa
import RxSwift
import UIKit

protocol ProfileManager {
    var uid: String { get }
    var name: String { get }
    var rating: Double { get }
    
    var organizedEvents: Driver<[Event]> { get }
    var participateInEvents: Driver<[Event]> { get }
    var recommendedEvents: Driver<[Event]> { get }
}

final class ProfileManagerImpl: ProfileManager {
    var uid: String {
        return "1"
    }
    
    var name: String {
        return UserDefaults.standard.string(forKey: "userName") ?? L10n.Profile.Avatar.Name.default
    }
    
    var rating: Double {
        return 0.0
    }
    
    var organizedEvents: Driver<[Event]> {
        return organizedEventsRelay.asDriver()
    }
    
    var participateInEvents: Driver<[Event]> {
        return participateInEventsRelay.asDriver()
    }
    
    var recommendedEvents: Driver<[Event]> {
        return recommendedEventsRelay.asDriver()
    }
    
    private let organizedEventsRelay = BehaviorRelay<[Event]>(value: [])
    private let participateInEventsRelay = BehaviorRelay<[Event]>(value: [])
    private let favoriteEventsRelay = BehaviorRelay<[Event]>(value: [])
    private let recommendedEventsRelay = BehaviorRelay<[Event]>(value: [])
    private let isInitializedRelay = PublishRelay<Bool>()
    private let recommender: Recommender
    private let database = Firestore.firestore()
    private let disposeBag = DisposeBag()
    
    private let group = DispatchGroup()
    private var user: AppUser?
    
    init(recommender: Recommender) {
        self.recommender = recommender
        self.recommender.recommendedEvents
            .bind(to: self.recommendedEventsRelay)
            .disposed(by: self.disposeBag)
        
        DispatchQueue.global(qos: .background).async {
            self.group.enter()
            self.database.collection("users").document(self.uid)
                .collection("my")
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    let events = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    
                    self.organizedEventsRelay.accept(events)
                    self.group.leave()
                }
        }
            
        DispatchQueue.global(qos: .background).async {
            self.group.enter()
            self.database.collection("users").document(self.uid)
                .collection("participateIn")
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else {
                        return
                    }
                    
                    let events = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    
                    self.participateInEventsRelay.accept(events)
                    self.group.leave()
                }
        }
        
        DispatchQueue.global(qos: .background).async {
            self.group.enter()
            self.database.collection("users").document(self.uid)
                .collection("favorites")
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else {
                        return
                    }
                    
                    let events = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    
                    self.favoriteEventsRelay.accept(events)
                    self.group.leave()
                }
        }
        
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            self.user = AppUser(
                id: self.uid,
                my: self.organizedEventsRelay.value,
                participateIn: self.participateInEventsRelay.value,
                favorites: self.favoriteEventsRelay.value
            )
            self.recommender.updateRecommendations(for: self.user!)
        }
    }
}
