//
//  PickLocationModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 25/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class PickLocationModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PickLocationViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return PickLocationViewModel()
        }

        container.register(PickLocationModule.self) { resolver in
            let viewModel = resolver.resolve(PickLocationViewModel.self)!
            let view = PickLocationViewController(viewModel: viewModel)
            
            return PickLocationModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
