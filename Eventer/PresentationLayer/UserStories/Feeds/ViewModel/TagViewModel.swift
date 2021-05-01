//
//  TagViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 25.04.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

class TagViewModel {
    let tag: Tag
    var isSelected: Bool
    
    init(tag: Tag, isSelected: Bool = false) {
        self.tag = tag
        self.isSelected = isSelected
    }
}
