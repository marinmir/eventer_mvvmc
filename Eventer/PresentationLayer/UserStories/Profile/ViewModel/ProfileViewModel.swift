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

/// Describes view model's input streams/single methods
protocol ProfileViewModelInput {
    func onViewDidLoad()
}

/// Describes view model's output streams needed to update UI
protocol ProfileViewModelOutput {
    var sections: Driver<[ProfileSectionViewModel]> { get }
}

protocol ProfileViewModelBindable: ProfileViewModelInput & ProfileViewModelOutput {}

final class ProfileViewModel: ProfileModuleInput & ProfileModuleOutput {
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
    
    init(profileManager: ProfileManager, eventsService: EventsService) {
        self.profileManager = profileManager
        self.eventsService = eventsService
        
//        profileManager.organizedEvents.drive(onNext: { events in
//            var sections = self.sectionsRelay.value
//            
//            switch sections[1] {
//            case .items(let items):
//                switch items[1] {
//                case .plain(_, details: <#T##String?#>):
//                    <#code#>
//                default:
//                    <#code#>
//                }
//            }
//        }).disposed(by: disposeBag)
    }
}

// MARK: - ProfileViewModelBindable implementation

extension ProfileViewModel: ProfileViewModelBindable {
    var sections: Driver<[ProfileSectionViewModel]> {
        return sectionsRelay.asDriver()
    }
    
    func onViewDidLoad() {
        
    }
}
