//
//  FavouritesViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol FavouritesViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol FavouritesViewModelOutput {}

protocol FavouritesViewModelBindable: FavouritesViewModelInput & FavouritesViewModelOutput {}

final class FavouritesViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - FavouritesViewModelBindable implementation

extension FavouritesViewModel: FavouritesViewModelBindable {
	// Describe all bindings here
}

// MARK: - FavouritesModuleInput implementation

extension FavouritesViewModel: FavouritesModuleInput {}

// MARK: - FavouritesModuleOutput implementation

extension FavouritesViewModel: FavouritesModuleOutput {}
