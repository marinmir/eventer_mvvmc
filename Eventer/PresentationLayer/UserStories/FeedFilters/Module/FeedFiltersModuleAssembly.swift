//
//  FeedFiltersModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 01/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class FeedFiltersModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FeedFiltersViewModel.self) { (resolver, initialFilters: [FeedFilter]) in
            return FeedFiltersViewModel(initialFilters: initialFilters)
        }

        container.register(FeedFiltersModule.self) { (resolver, initialFilters: [FeedFilter]) in
            let viewModel = resolver.resolve(FeedFiltersViewModel.self, argument: initialFilters)!
            let view = FeedFiltersViewController(viewModel: viewModel)
            
            return FeedFiltersModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
