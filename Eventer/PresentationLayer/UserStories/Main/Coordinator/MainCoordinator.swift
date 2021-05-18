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

    private var tabBarController: UITabBarController?
    
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
            
            self.tabBarController = tabBarController
            tabBarController.view.backgroundColor = Asset.Colors.white.color
            
            let feedsModule = resolver.resolve(FeedsModule.self)!
            let feedsTabItem = UITabBarItem(title: nil,
                                            image: Asset.TabBars.feeds.image,
                                            selectedImage: Asset.SelectedTabBars.selectedFeeds.image)
            feedsModule.output.onEventDetailsRequested = onEventDetailsRequested
            feedsModule.output.onFiltersRequested = onFiltersRequested
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
                UINavigationController(rootViewController: feedsModule.view),
                mapModule.view,
                createEventModule.view,
                UINavigationController(rootViewController: favouritesModule.view),
                profileModule.view
            ]

            tabBarController.setViewControllers(tabBarList, animated: true)

            window.rootViewController = tabBarController
        }
	}
    
    private func onEventDetailsRequested(event: Event) {
        if let navigationController = getActiveNavigationController() {
            let eventDetailsCoordinator = EventDetailsCoordinator(navigationController: navigationController, event: event)
            
            coordinate(to: eventDetailsCoordinator)
        }
    }
    
    private func onFiltersRequested(activeFilters: [FeedFilter]) {
        if let navigationController = getActiveNavigationController() {
            let filtersCoordinator = FeedFiltersCoordinator(navigationController: navigationController, initialFilters: activeFilters)
            
            filtersCoordinator.onComplete = { result in
                switch result {
                    case .cancelled:
                        break
                    case .appliedFilters(let filters):
                        break
                }
            }
            
            coordinate(to: filtersCoordinator)
        }
    }
    
    private func getActiveNavigationController() -> UINavigationController? {
        return tabBarController?.selectedViewController as? UINavigationController
    }
}
