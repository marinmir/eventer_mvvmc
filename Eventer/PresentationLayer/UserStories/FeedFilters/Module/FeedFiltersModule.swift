//
//  FeedFiltersModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 01/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol FeedFiltersModuleInput: AnyObject {}

protocol FeedFiltersModuleOutput: AnyObject {
    var onComplete: (([FeedFilter]) -> Void)? { get set }
    var onCancelled: (() -> Void)? { get set }
}

final class FeedFiltersModule: BaseModule<FeedFiltersModuleInput, FeedFiltersModuleOutput> {}
