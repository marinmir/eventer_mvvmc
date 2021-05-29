//
//  LocationManager.swift
//  Eventer
//
//  Created by  Магин Ярослав on 28.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

protocol LocationManager: class {
    var userLocation: Driver<CLLocation> { get }
    func enableLocationServices()
    
    func getAddress(for location: CLLocation) -> Single<CLPlacemark?>
}

final class LocationManagerImpl: NSObject, LocationManager {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let userLocationRelay: BehaviorRelay<CLLocation> // Taganrog, Railway station
    
    private enum Constants {
        static let locationKey = "loc"
    }
    
    var userLocation: Driver<CLLocation> {
        return userLocationRelay.asDriver()
    }
    
    override init() {
        if let cachedLocation = UserDefaults.standard.object(forKey: Constants.locationKey) as? Data,
           let encodedLocation = NSKeyedUnarchiver.unarchiveObject(with: cachedLocation) as? CLLocation {
            userLocationRelay = BehaviorRelay<CLLocation>(value: encodedLocation)
        } else {
            userLocationRelay = BehaviorRelay<CLLocation>(value: .init(latitude: 47.224587, longitude: 38.9004286))
        }
        
        super.init()
        locationManager.delegate = self
    }
    
    func enableLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
    }
    
    func getAddress(for location: CLLocation) -> Single<CLPlacemark?> {
        return Single.create { single in
            self.geocoder.reverseGeocodeLocation(location) { result, error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success(result?.first))
                }
            }
            
            return Disposables.create()
        }
    }
}

extension LocationManagerImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocationRelay.accept(location)
            
            let encodedLocation = NSKeyedArchiver.archivedData(withRootObject: location)
            UserDefaults.standard.set(encodedLocation, forKey: Constants.locationKey)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
