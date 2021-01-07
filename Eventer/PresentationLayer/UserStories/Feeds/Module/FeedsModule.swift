//
//  FeedsModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol FeedsModuleInput: AnyObject {}

protocol FeedsModuleOutput: AnyObject {}

final class FeedsModule: BaseModule<FeedsModuleInput, FeedsModuleOutput> {}