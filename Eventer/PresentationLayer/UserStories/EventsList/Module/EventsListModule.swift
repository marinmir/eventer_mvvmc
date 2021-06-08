//
//  EventsListModule.swift
//  Eventer
//
//  Created by Yaroslav Magin on 06/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol EventsListModuleInput: AnyObject {}

protocol EventsListModuleOutput: AnyObject {
    var onEventDetailsRequested: ((Event) -> Void)? { get set }
}

final class EventsListModule: BaseModule<EventsListModuleInput, EventsListModuleOutput> {}
