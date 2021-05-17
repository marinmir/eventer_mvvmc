//
//  EventAnnotation.swift
//  Eventer
//
//  Created by Ярослав Магин on 18.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import MapKit

final class EventAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    let event: Event
    
    init(event: Event) {
        self.event = event
        title = event.title
        coordinate = CLLocationCoordinate2D(latitude: event.location.lat, longitude: event.location.long)
        super.init()
    }
}
