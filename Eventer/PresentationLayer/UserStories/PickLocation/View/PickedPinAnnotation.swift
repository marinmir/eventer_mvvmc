//
//  PickedPinAnnotation.swift
//  Eventer
//
//  Created by  Магин Ярослав on 29.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import MapKit
import Foundation

final class PickedPinAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(viewModel: PickedPinViewModel) {
        title = viewModel.address
        coordinate = viewModel.location.coordinate
    }
}
