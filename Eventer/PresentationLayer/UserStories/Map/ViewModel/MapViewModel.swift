//
//  MapViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol MapViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol MapViewModelOutput {}

protocol MapViewModelBindable: MapViewModelInput & MapViewModelOutput {}

final class MapViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - MapViewModelBindable implementation

extension MapViewModel: MapViewModelBindable {
	// Describe all bindings here
}

// MARK: - MapModuleInput implementation

extension MapViewModel: MapModuleInput {}

// MARK: - MapModuleOutput implementation

extension MapViewModel: MapModuleOutput {}
