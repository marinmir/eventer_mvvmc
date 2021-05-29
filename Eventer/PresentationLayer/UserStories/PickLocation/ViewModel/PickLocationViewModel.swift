//
//  PickLocationViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 25/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol PickLocationViewModelInput {
    func onLocationTapped(_ location: CLLocation)
    
    func onCancel()
    func onAccept()
}

/// Describes view model's output streams needed to update UI
protocol PickLocationViewModelOutput {
    var userLocation: Driver<CLLocation> { get }
    var activePlacemark: Signal<PickedPinViewModel> { get }
}

protocol PickLocationViewModelBindable: PickLocationViewModelInput & PickLocationViewModelOutput {}

final class PickLocationViewModel: PickLocationModuleInput & PickLocationModuleOutput {
    var onClosed: (() -> Void)?
    var onLocationSelected: ((PickedPinViewModel) -> Void)?
    
    private let locationManager: LocationManager
    private let activePlacemarkRelay = PublishRelay<PickedPinViewModel>()
    private let disposeBag = DisposeBag()
    private var lastTappedLocation: PickedPinViewModel?
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
}

// MARK: - PickLocationViewModelBindable implementation

extension PickLocationViewModel: PickLocationViewModelBindable {
    var userLocation: Driver<CLLocation> {
        return locationManager.userLocation
    }
    
    var activePlacemark: Signal<PickedPinViewModel> {
        return activePlacemarkRelay.asSignal()
    }
    
    func onLocationTapped(_ location: CLLocation) {
        
        locationManager.getAddress(for: location)
            .subscribe(onSuccess: { result in
                if let result = result {
                    self.lastTappedLocation = PickedPinViewModel(
                        address: result.name,
                        city: result.subLocality,
                        location: location
                    )
                    self.activePlacemarkRelay.accept(self.lastTappedLocation!)
                }
            }).disposed(by: disposeBag)
    }
    
    func onCancel() {
        onClosed?()
    }
    
    func onAccept() {
        if let location = lastTappedLocation {
            self.onLocationSelected?(location)
        }
    }
}
