//
//  MainCoordinator.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd.. All rights reserved.
//

import InoMvvmc
import Swinject
import UIKit

final class MainCoordinator: BaseCoordinator<Void> {

	override func assemblies() -> [Assembly] {
		return [
            MainModuleAssembly(),
            FeedsModuleAssembly(),
            MapModuleAssembly(),
            CreateEventModuleAssembly(),
            FavouritesModuleAssembly(),
            ProfileModuleAssembly()
        ]
	}

	override func start() {
        if let window = UIApplication.shared.keyWindow {
            let mainModule = resolver.resolve(MainModule.self)!
            guard let tabBarController = mainModule.view as? UITabBarController else {
                return
            }
            
            let feedsModule = resolver.resolve(FeedsModule.self)!
            feedsModule.view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            
            let mapModule = resolver.resolve(MapModule.self)!
            mapModule.view.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
            
            let createEventModule = resolver.resolve(CreateEventModule.self)!
            createEventModule.view.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
            
            let favouritesModule = resolver.resolve(FavouritesModule.self)!
            favouritesModule.view.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
            
            let profileModule = resolver.resolve(ProfileModule.self)!
            profileModule.view.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
            
            let tabBarList = [
                feedsModule.view,
                mapModule.view,
                createEventModule.view,
                favouritesModule.view,
                profileModule.view
            ]
            
            tabBarController.viewControllers = tabBarList
            
            window.rootViewController = tabBarController
        }
	}
}
