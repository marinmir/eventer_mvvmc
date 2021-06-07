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
        container.register(RecommenderDataSource.self) { _ in
            return RecommenderDataSourceImpl()
        }
        
        container.register(Recommender.self) { resolver in
            let dataSource = resolver.resolve(RecommenderDataSource.self)!
            return RecommenderImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(ProfileManager.self) { resolver in
            let recommender = resolver.resolve(Recommender.self)!
            return ProfileManagerImpl(recommender: recommender)
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
