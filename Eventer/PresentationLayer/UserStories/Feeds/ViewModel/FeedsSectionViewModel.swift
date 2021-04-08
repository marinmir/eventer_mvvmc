//
//  FeedsSectionViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 22.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

enum FeedsSectionViewModel {
    case tagList(tags: [Tag])
    case popularEvents(_ events: [Event])
    case weekendEvents(_ events: [Event])
    case promotedEvents(_ events: [Event])
}
