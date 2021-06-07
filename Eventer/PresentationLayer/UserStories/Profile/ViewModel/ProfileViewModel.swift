//
//  ProfileViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum ProfileNavigationAction {
    case termsOfUse
    case about
    case recommended([Event])
    case organized([Event])
    case participateIn([Event])
}

enum ProfileCellAction {
    case termsOfUse
    case about
    case recommended
    case organized
    case participateIn
}

/// Describes view model's input streams/single methods
protocol ProfileViewModelInput {
    func onViewDidLoad()
    func onActionTapped(_ action: ProfileCellAction)
}

/// Describes view model's output streams needed to update UI
protocol ProfileViewModelOutput {
    var sections: Driver<[ProfileSectionViewModel]> { get }
}

protocol ProfileViewModelBindable: ProfileViewModelInput & ProfileViewModelOutput {}

final class ProfileViewModel: ProfileModuleInput & ProfileModuleOutput {
    var onNavigationActionRequested: ((ProfileNavigationAction) -> Void)?
    
    private let disposeBag = DisposeBag()
    private let sectionsRelay = BehaviorRelay<[ProfileSectionViewModel]>(value: [
        .avatar(AvatarViewModel(
                    image: Asset.profileDefault.image,
                    stars: 0.0,
                    name: L10n.Profile.Avatar.Name.default
        )),
        .items([
            .plain(text: L10n.Profile.Events.organized, details: nil),
            .plain(text: L10n.Profile.Events.participate, details: nil),
            .plain(text: L10n.Profile.Events.recommendations, details: nil)
        ]),
        .items([
            .plain(text: L10n.Profile.Info.termsOfUse, details: nil),
            .plain(text: L10n.Profile.Info.about, details: nil)
        ]),
        .items([
            .logout
        ])
    ])
    private let profileManager: ProfileManager
    private let eventsService: EventsService
    
    private var organizedEvents: [Event] = []
    private var participateInEvents: [Event] = []
    private var recommendedEvents: [Event] = []
    
    init(profileManager: ProfileManager, eventsService: EventsService) {
        self.profileManager = profileManager
        self.eventsService = eventsService
        
        profileManager.organizedEvents.drive(onNext: { events in
            self.organizedEvents = events
        }).disposed(by: disposeBag)
        
        profileManager.participateInEvents.drive(onNext: { events in
            self.participateInEvents = events
        }).disposed(by: disposeBag)
        
        profileManager.recommendedEvents.drive(onNext: { events in
            self.recommendedEvents = events
        }).disposed(by: disposeBag)
    }
    
    
}

// MARK: - ProfileViewModelBindable implementation

extension ProfileViewModel: ProfileViewModelBindable {
    var sections: Driver<[ProfileSectionViewModel]> {
        return sectionsRelay.asDriver()
    }
    
    func onViewDidLoad() {
        
    }
    
    func onActionTapped(_ action: ProfileCellAction) {
        switch action {
        case .about:
            onNavigationActionRequested?(.about)
        case .termsOfUse:
            onNavigationActionRequested?(.termsOfUse)
        case .recommended:
            onNavigationActionRequested?(.recommended(recommendedEvents))
        case .participateIn:
            onNavigationActionRequested?(.participateIn(participateInEvents))
        case .organized:
            onNavigationActionRequested?(.organized(organizedEvents))
        }
    }
}
