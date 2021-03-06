//
//  FeedsModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol FeedsModuleInput: AnyObject {
    func onFiltersApplied(filters: [FeedFilter])
}

protocol FeedsModuleOutput: AnyObject {
    var onEventDetailsRequested: ((Event) -> Void)? { get set }
    var onFiltersRequested: (([FeedFilter]) -> Void)? { get set }
}

final class FeedsModule: BaseModule<FeedsModuleInput, FeedsModuleOutput> {}
