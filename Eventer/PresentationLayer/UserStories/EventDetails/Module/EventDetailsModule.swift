//
//  EventDetailsModule.swift
//  Eventer
//
//  Created by Ярослав Магин on 11/04/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import InoMvvmc

protocol EventDetailsModuleInput: AnyObject {}

protocol EventDetailsModuleOutput: AnyObject {}

final class EventDetailsModule: BaseModule<EventDetailsModuleInput, EventDetailsModuleOutput> {}
