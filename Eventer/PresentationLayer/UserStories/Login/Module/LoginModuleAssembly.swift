//
//  LoginModuleAssembly.swift
//  Eventer
//
//  Created by Yaroslav Magin on 10/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Swinject

final class LoginModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return LoginViewModel()
        }

        container.register(LoginModule.self) { resolver in
            let viewModel = resolver.resolve(LoginViewModel.self)!
            let view = LoginViewController(viewModel: viewModel)
            
            return LoginModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
