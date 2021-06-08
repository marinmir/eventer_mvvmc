//
//  EventsListCoordinator.swift
//  Eventer
//
//  Created by Yaroslav Magin on 06/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import InoMvvmc
import Swinject

final class EventsListCoordinator: BaseCoordinator<Void> {
    private let navigationController: UINavigationController
    private let events: [Event]
    private let title: String
    
    init(title: String, events: [Event], navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.events = events
        self.title = title
        super.init()
    }
    
	override func assemblies() -> [Assembly] {
		return [
			EventsListModuleAssembly()
		]
	}

	override func start() {
        let module = resolver.resolve(EventsListModule.self, argument: events)!
        
        module.view.title = title
        
        module.output.onEventDetailsRequested = { event in
            let coordinator = EventDetailsCoordinator(navigationController: self.navigationController, event: event)
            self.coordinate(to: coordinator)
        }
        
        navigationController.pushViewController(module.view, animated: true)
	}
}
