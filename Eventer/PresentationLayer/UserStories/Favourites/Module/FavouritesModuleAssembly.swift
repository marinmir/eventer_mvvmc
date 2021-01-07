//
//  FavouritesModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class FavouritesModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FavouritesViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return FavouritesViewModel()
        }

        container.register(FavouritesModule.self) { resolver in
            let viewModel = resolver.resolve(FavouritesViewModel.self)!
            let view = FavouritesViewController(viewModel: viewModel)

            return FavouritesModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
