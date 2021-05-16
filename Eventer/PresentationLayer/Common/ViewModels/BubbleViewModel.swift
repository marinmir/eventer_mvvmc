//
//  BubbleViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 03.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import UIKit

class BubbleViewModel {
    let image: UIImage?
    let selectedImage: UIImage?
    let text: String
    var isSelected: Bool
    
    init(
        image: UIImage?,
        selectedImage: UIImage?,
        text: String,
        isSelected: Bool = false
    ) {
        self.image = image
        self.selectedImage = selectedImage
        self.text = text
        self.isSelected = isSelected
    }
}
