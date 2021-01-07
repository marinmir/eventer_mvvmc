//
//  UIImageView+.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 09.09.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseUI
import FirebaseStorage

extension UIImageView {
    func loadImage(url: String) {
        let ref = Storage.storage().reference(withPath: url)
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with: ref, placeholderImage: UIImage())
    }
}
