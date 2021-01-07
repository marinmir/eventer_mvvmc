//
//  MainModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd.. All rights reserved.
//

import Swinject

final class MainModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return MainViewModel()
        }

        container.register(MainModule.self) { resolver in
            let viewModel = resolver.resolve(MainViewModel.self)!
            let view = MainViewController(viewModel: viewModel)

            return MainModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
