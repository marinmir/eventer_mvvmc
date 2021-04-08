//
//  SearchResultsModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 09/03/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol SearchResultsModuleInput: AnyObject {}

protocol SearchResultsModuleOutput: AnyObject {}

final class SearchResultsModule: BaseModule<SearchResultsModuleInput, SearchResultsModuleOutput> {}
