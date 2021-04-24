//
//  EventDetailsCoordinator.swift
//  Eventer
//
//  Created by Ярослав Магин on 11/04/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import InoMvvmc
import Swinject

final class EventDetailsCoordinator: BaseCoordinator<Void> {
	// Replace <Void> with some other result type if necessary
    private let navigationController: UINavigationController
    private let event: Event
    
    init(navigationController: UINavigationController, event: Event) {
        self.navigationController = navigationController
        self.event = event
    }

	override func assemblies() -> [Assembly] {
		return [
			EventDetailsModuleAssembly()
		]
	}

	override func start() {
        let module = resolver.resolve(EventDetailsModule.self, argument: event)!
        
        navigationController.pushViewController(module.view, animated: true)
	}
}
