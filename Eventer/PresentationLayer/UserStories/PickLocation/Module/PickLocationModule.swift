//
//  PickLocationModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 25/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import CoreLocation
import Foundation
import InoMvvmc

protocol PickLocationModuleInput: AnyObject {}

protocol PickLocationModuleOutput: AnyObject {
    var onClosed: (() -> Void)? { get set }
    var onLocationSelected: ((CLLocation) -> Void)? { get set }
}

final class PickLocationModule: BaseModule<PickLocationModuleInput, PickLocationModuleOutput> {}
