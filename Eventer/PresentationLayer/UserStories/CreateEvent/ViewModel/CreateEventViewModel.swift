//
//  CreateEventViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol CreateEventViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol CreateEventViewModelOutput {}

protocol CreateEventViewModelBindable: CreateEventViewModelInput & CreateEventViewModelOutput {}

final class CreateEventViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - CreateEventViewModelBindable implementation

extension CreateEventViewModel: CreateEventViewModelBindable {
	// Describe all bindings here
}

// MARK: - CreateEventModuleInput implementation

extension CreateEventViewModel: CreateEventModuleInput {}

// MARK: - CreateEventModuleOutput implementation

extension CreateEventViewModel: CreateEventModuleOutput {}
