//
//  CreateEventModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class CreateEventModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CreateEventViewModel.self) { resolver in
            let eventsService = resolver.resolve(EventsService.self)!
            return CreateEventViewModel(eventsService: eventsService)
        }

        container.register(CreateEventModule.self) { resolver in
            let viewModel = resolver.resolve(CreateEventViewModel.self)!
            let view = CreateEventViewController(viewModel: viewModel)

            return CreateEventModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
