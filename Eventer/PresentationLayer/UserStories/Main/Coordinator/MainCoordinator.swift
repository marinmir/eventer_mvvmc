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
            let feedsTabItem = UITabBarItem(title: nil,
                                            image: Asset.TabBars.feeds.image,
                                            selectedImage: Asset.SelectedTabBars.selectedFeeds.image)
            feedsModule.view.tabBarItem = feedsTabItem

            let mapModule = resolver.resolve(MapModule.self)!
            let mapTabItem = UITabBarItem(title: nil,
                                          image: Asset.TabBars.map.image,
                                          selectedImage: Asset.SelectedTabBars.selectedMap.image)
            mapModule.view.tabBarItem = mapTabItem

            let createEventModule = resolver.resolve(CreateEventModule.self)!
            let createEventTabItem = UITabBarItem(title: nil,
                                                  image: Asset.TabBars.createEvent.image,
                                                  selectedImage: Asset.SelectedTabBars.selectedCreateEvent.image)
            createEventModule.view.tabBarItem = createEventTabItem

            let favouritesModule = resolver.resolve(FavouritesModule.self)!
            let favouritesTabItem = UITabBarItem(title: nil,
                                                 image: Asset.TabBars.favourites.image,
                                                 selectedImage: Asset.SelectedTabBars.selectedFavourites.image)
            favouritesModule.view.tabBarItem = favouritesTabItem

            let profileModule = resolver.resolve(ProfileModule.self)!
            let profileTabItem = UITabBarItem(title: nil,
                                              image: Asset.TabBars.profile.image,
                                              selectedImage: Asset.SelectedTabBars.selectedProfile.image)
            profileModule.view.tabBarItem = profileTabItem

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
