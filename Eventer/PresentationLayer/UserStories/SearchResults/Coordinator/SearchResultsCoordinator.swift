//
//  SearchResultsCoordinator.swift
//  Eventer
//
//  Created by Ярослав Магин on 09/03/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import InoMvvmc
import Swinject

final class SearchResultsCoordinator: BaseCoordinator<Void> {
	// Replace <Void> with some other result type if necessary

	override func assemblies() -> [Assembly] {
		return [
			SearchResultsModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
	}
}
