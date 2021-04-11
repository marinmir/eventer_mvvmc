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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

	override func assemblies() -> [Assembly] {
		return [
			EventDetailsModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
	}
}
