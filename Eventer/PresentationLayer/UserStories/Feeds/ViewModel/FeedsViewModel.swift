//
//  FeedsViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol FeedsViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol FeedsViewModelOutput {}

protocol FeedsViewModelBindable: FeedsViewModelInput & FeedsViewModelOutput {}

final class FeedsViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - FeedsViewModelBindable implementation

extension FeedsViewModel: FeedsViewModelBindable {
	// Describe all bindings here
}

// MARK: - FeedsModuleInput implementation

extension FeedsViewModel: FeedsModuleInput {}

// MARK: - FeedsModuleOutput implementation

extension FeedsViewModel: FeedsModuleOutput {}
