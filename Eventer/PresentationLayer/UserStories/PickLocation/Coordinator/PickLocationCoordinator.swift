//
//  PickLocationCoordinator.swift
//  Eventer
//
//  Created by Ярослав Магин on 25/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import CoreLocation
import InoMvvmc
import Swinject

enum PickLocationCoordinatorResult {
    case closed
    case location(PickedPinViewModel)
}

final class PickLocationCoordinator: BaseCoordinator<PickLocationCoordinatorResult> {
    private let presentingController: UIViewController

    init(viewController: UIViewController) {
        presentingController = viewController
    }
    
	override func assemblies() -> [Assembly] {
		return [
			PickLocationModuleAssembly()
		]
	}

	override func start() {
        let module = resolver.resolve(PickLocationModule.self)!
        
        module.output.onClosed = {
            module.view.dismiss(animated: true)
            self.onComplete?(.closed)
        }
        
        module.output.onLocationSelected = { location in
            module.view.dismiss(animated: true)
            self.onComplete?(.location(location))
        }
        
        presentingController.present(
            UINavigationController(rootViewController: module.view),
            animated: true
        )
	}
}
