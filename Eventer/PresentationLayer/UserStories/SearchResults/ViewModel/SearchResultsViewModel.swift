//
//  SearchResultsViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 09/03/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol SearchResultsViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol SearchResultsViewModelOutput {}

protocol SearchResultsViewModelBindable: SearchResultsViewModelInput & SearchResultsViewModelOutput {}

final class SearchResultsViewModel: SearchResultsModuleInput & SearchResultsModuleOutput {
    private let disposeBag = DisposeBag()
}

// MARK: - SearchResultsViewModelBindable implementation

extension SearchResultsViewModel: SearchResultsViewModelBindable {
	// Describe all bindings here
}
