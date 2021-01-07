//
//  MainModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd.. All rights reserved.
//

import Foundation
import InoMvvmc

protocol MainModuleInput: AnyObject {}

protocol MainModuleOutput: AnyObject {}

final class MainModule: BaseModule<MainModuleInput, MainModuleOutput> {}
