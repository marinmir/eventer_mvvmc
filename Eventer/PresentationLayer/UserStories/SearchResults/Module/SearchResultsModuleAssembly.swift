//
//  SearchResultsModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 09/03/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class SearchResultsModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchResultsViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return SearchResultsViewModel()
        }

        container.register(SearchResultsModule.self) { resolver in
            let viewModel = resolver.resolve(SearchResultsViewModel.self)!
            let view = SearchResultsViewController(viewModel: viewModel)

            return SearchResultsModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
