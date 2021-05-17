//
//  MapModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class MapModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MapViewModel.self) { resolver in
            let eventsService = resolver.resolve(EventsService.self)!
            return MapViewModel(eventsService: eventsService)
        }

        container.register(MapModule.self) { resolver in
            let viewModel = resolver.resolve(MapViewModel.self)!
            let view = MapViewController(viewModel: viewModel)

            return MapModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
