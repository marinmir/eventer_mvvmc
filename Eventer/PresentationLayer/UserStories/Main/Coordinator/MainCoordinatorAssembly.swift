//
//  MainCoordinatorAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd.. All rights reserved.
//

import InoMvvmc
import Swinject

final class MainCoordinatorAssembly: Assembly {
	func assemble(container: Container) {
		container.register(MainCoordinator.self) { _ in
			// replace '_' with 'resolver' and inject other coordinators if necessary
			return MainCoordinator()
		}
	}
}
