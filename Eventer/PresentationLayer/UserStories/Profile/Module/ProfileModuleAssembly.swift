//
//  ProfileModuleAssembly.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class ProfileModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProfileViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return ProfileViewModel()
        }

        container.register(ProfileModule.self) { resolver in
            let viewModel = resolver.resolve(ProfileViewModel.self)!
            let view = ProfileViewController(viewModel: viewModel)
            
            return ProfileModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
