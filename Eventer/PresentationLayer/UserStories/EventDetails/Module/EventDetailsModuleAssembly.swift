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
        container.register(EventDetailsViewModel.self) { (resolver, event: Event) in
            return EventDetailsViewModel(event: event)
        }

        container.register(EventDetailsModule.self) { (resolver, event: Event) in
            let viewModel = resolver.resolve(EventDetailsViewModel.self, argument: event)!
            let view = EventDetailsViewController(viewModel: viewModel)
            
            return EventDetailsModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
