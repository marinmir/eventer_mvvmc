//
//  EventDetailsModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 11/04/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class EventDetailsModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventDetailsViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return EventDetailsViewModel()
        }

        container.register(EventDetailsModule.self) { resolver in
            let viewModel = resolver.resolve(EventDetailsViewModel.self)!
            let view = EventDetailsViewController(viewModel: viewModel)
            
            return EventDetailsModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
