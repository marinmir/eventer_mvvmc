//
//  RecommenderDataSource.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import RxSwift

protocol RecommenderDataSource {
    var isReady: Observable<Bool> { get }
    
    func startup()
    func getUsers() -> [AppUser]
}

final class RecommenderDataSourceImpl: RecommenderDataSource {
    private var appUsers: [AppUser] = []
    private let database = Firestore.firestore()
    private let isReadyRelay = BehaviorSubject<Bool>(value: false)
    
    private let usersGroup = DispatchGroup()
    private var loadedUsersGroups = [DispatchGroup]()
    
    var isReady: Observable<Bool> {
        return isReadyRelay.asObservable()
    }
    
    func startup() {
        database.collection("/users")
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    assert(false)
                    return
                }
                let ids = snapshot.documents.compactMap { $0.documentID }
                
                ids.forEach {
                    self.loadUser(with: $0)
                }
                
                self.usersGroup.notify(queue: DispatchQueue.global(qos: .utility)) {
                    self.isReadyRelay.onNext(true)
                }
                
                self.isReadyRelay.onNext(true)
            }
    }
    
    func getUsers() -> [AppUser] {
        return appUsers
    }
    
    private func loadUser(with id: String) {
        usersGroup.enter()
        let currentUserGroup = DispatchGroup()
        loadedUsersGroups.append(currentUserGroup)
        
        var organizedEvents: [Event] = []
        var participateInEvents: [Event] = []
        var favoriteEvents: [Event] = []
        
        currentUserGroup.enter()
        DispatchQueue.global(qos: .background).async {
            
            self.database.collection("/users").document(id)
                .collection("my")
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    organizedEvents = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    
                    currentUserGroup.leave()
                }
        }
            
        currentUserGroup.enter()
        DispatchQueue.global(qos: .background).async {
            
            self.database.collection("/users").document(id)
                .collection("participateIn")
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else {
                        return
                    }
                    
                    participateInEvents = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    
                    currentUserGroup.leave()
                }
        }
        
        currentUserGroup.enter()
        DispatchQueue.global(qos: .background).async {
            
            self.database.collection("/users").document(id)
                .collection("favorites")
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else {
                        return
                    }
                    
                    favoriteEvents = snapshot.documents.compactMap { try? $0.data(as: Event.self) }
                    
                    currentUserGroup.leave()
                }
        }
        
        currentUserGroup.notify(queue: DispatchQueue.global(qos: .background)) {
            self.appUsers.append(AppUser(id: id, my: organizedEvents, participateIn: participateInEvents, favorites: favoriteEvents))
            self.usersGroup.leave()
        }
    }
}
