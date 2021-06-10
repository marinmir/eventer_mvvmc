//
//  LoginModule.swift
//  Eventer
//
//  Created by Yaroslav Magin on 10/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol LoginModuleInput: AnyObject {}

protocol LoginModuleOutput: AnyObject {
    var onAuthSuccessful: (() -> Void)? { get set }
}

final class LoginModule: BaseModule<LoginModuleInput, LoginModuleOutput> {}
