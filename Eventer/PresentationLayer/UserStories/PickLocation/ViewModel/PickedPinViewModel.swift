//
//  PickedPinViewModel.swift
//  Eventer
//
//  Created by  Магин Ярослав on 29.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import CoreLocation
import Foundation

struct PickedPinViewModel {
    let address: String?
    let city: String?
    let location: CLLocation
}
