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
        container.register(FeedsViewModel.self) { resolver in
            let eventsService = resolver.resolve(EventsService.self)!
            return FeedsViewModel(eventsService: eventsService)
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
