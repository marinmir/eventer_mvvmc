//
//  ProfileManager.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
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
    private let recommendedEventsRelay = BehaviorRelay<[Event]>(value: [])
}
