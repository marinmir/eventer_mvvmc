//
//  EventsListModuleAssembly.swift
//  Eventer
//
//  Created by Yaroslav Magin on 06/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class EventsListModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventsListViewModel.self) { (resolver, eventsList: [Event]) in
            let eventsService = resolver.resolve(EventsService.self)!
            return EventsListViewModel(eventsList: eventsList, eventsService: eventsService)
        }

        container.register(EventsListModule.self) { (resolver, eventsList: [Event]) in
            let viewModel = resolver.resolve(EventsListViewModel.self, argument: eventsList)!
            let view = EventsListViewController(viewModel: viewModel)
            
            return EventsListModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
