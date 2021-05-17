//
//  MapViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol MapViewModelInput {
    func onViewDidLoad()
}

/// Describes view model's output streams needed to update UI
protocol MapViewModelOutput {
    var userLocation: Driver<CLLocation> { get }
    var mapEvents: Driver<[Event]> { get }
}

protocol MapViewModelBindable: MapViewModelInput & MapViewModelOutput {}

final class MapViewModel: NSObject, MapModuleInput & MapModuleOutput {
    private let disposeBag = DisposeBag()
    private let userLocationRelay = BehaviorRelay<CLLocation>(value: CLLocation())
    private let mapEventsRelay = BehaviorRelay<[Event]>(value: [])
    private let locationManager = CLLocationManager()
    private let eventsService: EventsService
    
    init(eventsService: EventsService) {
        self.eventsService = eventsService
        super.init()
        
        locationManager.delegate = self
        eventsService.loadedEvents.bind(to: mapEventsRelay).disposed(by: disposeBag)
    }
}

// MARK: - MapViewModelBindable implementation

extension MapViewModel: MapViewModelBindable {
    var userLocation: Driver<CLLocation> {
        return userLocationRelay.asDriver()
    }
    
    var mapEvents: Driver<[Event]> {
        return mapEventsRelay.asDriver()
    }
    
    func onViewDidLoad() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocationRelay.accept(location)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
