//
//  FeedsModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class FeedsModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FeedsViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return FeedsViewModel()
        }

        container.register(FeedsModule.self) { resolver in
            let viewModel = resolver.resolve(FeedsViewModel.self)!
            let view = FeedsViewController(viewModel: viewModel)
            
            return FeedsModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
