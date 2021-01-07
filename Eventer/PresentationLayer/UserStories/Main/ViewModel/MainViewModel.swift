//
//  MainViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd.. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol MainViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol MainViewModelOutput {}

protocol MainViewModelBindable: MainViewModelInput & MainViewModelOutput {}

final class MainViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - MainViewModelBindable implementation

extension MainViewModel: MainViewModelBindable {
	// Describe all bindings here
}

// MARK: - MainModuleInput implementation

extension MainViewModel: MainModuleInput {}

// MARK: - MainModuleOutput implementation

extension MainViewModel: MainModuleOutput {}
