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
}

/// Describes view model's output streams needed to update UI
protocol PickLocationViewModelOutput {}

protocol PickLocationViewModelBindable: PickLocationViewModelInput & PickLocationViewModelOutput {}

final class PickLocationViewModel: PickLocationModuleInput & PickLocationModuleOutput {
    var onClosed: (() -> Void)?
    var onLocationSelected: ((CLLocation) -> Void)?
    
    private let disposeBag = DisposeBag()
}

// MARK: - PickLocationViewModelBindable implementation

extension PickLocationViewModel: PickLocationViewModelBindable {
    func onLocationTapped(_ location: CLLocation) {
        
    }
}
