//
//  ProfileViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol ProfileViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol ProfileViewModelOutput {}

protocol ProfileViewModelBindable: ProfileViewModelInput & ProfileViewModelOutput {}

final class ProfileViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - ProfileViewModelBindable implementation

extension ProfileViewModel: ProfileViewModelBindable {
	// Describe all bindings here
}

// MARK: - ProfileModuleInput implementation

extension ProfileViewModel: ProfileModuleInput {}

// MARK: - ProfileModuleOutput implementation

extension ProfileViewModel: ProfileModuleOutput {}
