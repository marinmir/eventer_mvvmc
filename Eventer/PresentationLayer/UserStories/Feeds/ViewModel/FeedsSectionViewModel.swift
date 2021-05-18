//
//  FeedsSectionViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 22.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

enum FeedsSectionViewModel {
    case tagList(tags: [TagViewModel])
    case popularEvents(_ events: [EventCardViewModel])
    case weekendEvents(_ events: [EventCardViewModel])
    case promotedEvents(_ events: [EventCardViewModel])
}
