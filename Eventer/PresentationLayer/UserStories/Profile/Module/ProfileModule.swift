//
//  ProfileModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol ProfileModuleInput: AnyObject {}

protocol ProfileModuleOutput: AnyObject {
    var onNavigationActionRequested: ((ProfileNavigationAction) -> Void)? { get set }
}

final class ProfileModule: BaseModule<ProfileModuleInput, ProfileModuleOutput> {}
