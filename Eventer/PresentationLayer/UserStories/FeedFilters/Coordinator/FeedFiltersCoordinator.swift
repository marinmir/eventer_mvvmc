//
//  FeedFiltersCoordinator.swift
//  Eventer
//
//  Created by Ярослав Магин on 01/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import InoMvvmc
import Swinject

enum FilterLocation {
    case current
    case address(String)
}

enum FeedFilter {
    case location(FilterLocation)
    case date(start: Date?, end: Date?)
    case timeOfDay(TimeOfDay)
    case price(start: Double?, end: Double?)
}

enum FeedFiltersResult {
    case appliedFilters([FeedFilter])
    case cancelled
}

final class FeedFiltersCoordinator: BaseCoordinator<FeedFiltersResult> {

    private let navigationController: UINavigationController
    private let initialFilters: [FeedFilter]
    
    init(navigationController: UINavigationController, initialFilters: [FeedFilter]) {
        self.navigationController = navigationController
        self.initialFilters = initialFilters
    }
    
	override func assemblies() -> [Assembly] {
		return [
			FeedFiltersModuleAssembly()
		]
	}

	override func start() {
        let module = resolver.resolve(FeedFiltersModule.self, argument: initialFilters)!
        
        module.output.onCancelled = {
            self.onComplete?(.cancelled)
        }
        
        module.output.onComplete = { filters in
            module.output.onCancelled = nil
            self.navigationController.popViewController(animated: true)
            self.onComplete?(.appliedFilters(filters))
        }
        
        navigationController.pushViewController(module.view, animated: true)
	}
}
