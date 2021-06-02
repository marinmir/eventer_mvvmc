//
//  ServicesAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 23.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import Swinject

final class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProfileManager.self) { _ in
            return ProfileManagerImpl()
        }.inObjectScope(.container)
        
        container.register(EventsService.self) { resolver in
            let profileManager = resolver.resolve(ProfileManager.self)!
            return EventsServiceImpl(profileManager: profileManager)
        }.inObjectScope(.container)
        
        container.register(LocationManager.self) { _ in
            return LocationManagerImpl()
        }.inObjectScope(.container)
    }
}
