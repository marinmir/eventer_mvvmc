//
//  LoginCoordinator.swift
//  Eventer
//
//  Created by Yaroslav Magin on 10/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import InoMvvmc
import Swinject

final class LoginCoordinator: BaseCoordinator<Void> {
	// Replace <Void> with some other result type if necessary

	override func assemblies() -> [Assembly] {
		return [
			LoginModuleAssembly()
		]
	}

	override func start() {
        if let window = UIApplication.shared.keyWindow {
            let loginModule = resolver.resolve(LoginModule.self)!

            loginModule.output.onAuthSuccessful = onCompleteJustClose(with: ())

            window.rootViewController = loginModule.view
        }
	}
}
