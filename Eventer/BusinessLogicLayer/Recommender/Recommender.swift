//
//  Recommender.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import RxSwift

protocol Recommender {
    var recommendedEvents: Observable<[Event]> { get }
    
    func updateRecommendations(for user: AppUser)
}

final class RecommenderImpl: Recommender {
    
    private typealias MatrixItem = Int
    
    private enum Constants {
        static let favoriteWeight = 1
        static let createdWeight = 2
    }
    
    var recommendedEvents: Observable<[Event]> {
        return recommendedEventsSubject.asObservable()
    }
    
    private let dataSource: RecommenderDataSource
    private let recommendedEventsSubject = BehaviorSubject<[Event]>(value: [])
    
    init(dataSource: RecommenderDataSource) {
        self.dataSource = dataSource
    }
    
    func updateRecommendations(for user: AppUser) {
        let users = dataSource.getUsers()
        let uniqueEvents = getUniqueEvents(users: users)
        
        let weightMatrix = calculateWeightMatrix(for: users, using: uniqueEvents)
        
        guard let targetUserIndex = users.firstIndex(where: { $0.id == user.id }) else {
            return
        }
        
        var relativeRates = [Double](repeating: -1, count: users.count)
        for (index, row) in weightMatrix.enumerated() where index != targetUserIndex {
            let rate = rateVectors(weightMatrix[targetUserIndex], row)
            relativeRates[index] = rate
        }
        
        let topRecommendedRates = relativeRates.sorted(by: { $0 < $1 }).prefix(10)
        
        let eventsIndices = topRecommendedRates.map { relativeRates.firstIndex(of: $0)! }
        
        var result = [Event]()
        for eventIndex in eventsIndices {
            result.append(uniqueEvents[eventIndex])
        }
        
        recommendedEventsSubject.onNext(result)
    }
    
    private func getUniqueEvents(users: [AppUser]) -> [Event] {
        var uniqueEvents = Set<Event>()
        
        users.forEach { user in
            user.favorites.forEach { event in
                uniqueEvents.insert(event)
            }
            
            user.my.forEach { event in
                uniqueEvents.insert(event)
            }
        }
        
        return Array(uniqueEvents)
    }
    
    private func calculateMatrixRow(for user: AppUser, on events: [Event]) -> [MatrixItem] {
        var row = [MatrixItem](repeating: 0, count: events.count)
        
        for (index, event) in events.enumerated() {
            var weight = 0
            if user.favorites.first(where: { $0.id == event.id }) != nil {
                weight += 1
            }
            
            if user.my.first(where: { $0.id == event.id }) != nil {
                weight += 2
            }
            
            row[index] = weight
        }
        
        return row
    }
    
    private func calculateWeightMatrix(for users: [AppUser], using uniqueEvents: [Event]) -> [[MatrixItem]] {
        var matrix = [[MatrixItem]]()
        
        users.forEach { user in
            matrix.append(calculateMatrixRow(for: user, on: uniqueEvents))
        }
        
        return matrix
    }
    
    private func rateVectors(_ first: [MatrixItem], _ second: [MatrixItem]) -> Double {
        var value = 0
        
        for index in first.indices {
            value += first[index] * second[index]
        }
        
        return Double(value) / (first.vectorLength() * second.vectorLength())
    }
}

fileprivate extension Array where Element == Int {
    func vectorLength() -> Double {
        return sqrt(Double(reduce(0, { sum, item in
            return sum + item * item
        })))
    }
}
