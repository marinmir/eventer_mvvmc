//
//  Tags.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 10.08.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

struct Tag {
    var image: UIImage
    var selectedImage: UIImage
    var name: String
}

class Tags {
    static let tags = [ Tag(image: UIImage(named: "Art")!,
                            selectedImage: UIImage(named: "SelectedArt")!,
                            name: NSLocalizedString("Art", comment: "")),
                        Tag(image: UIImage(named: "Cinema")!,
                            selectedImage: UIImage(named: "SelectedCinema")!,
                            name: NSLocalizedString("Cinema", comment: "")),
                        Tag(image: UIImage(named: "Food")!,
                            selectedImage: UIImage(named: "SelectedFood")!,
                            name: NSLocalizedString("Food", comment: "")),
                        Tag(image: UIImage(named: "Music")!,
                            selectedImage: UIImage(named: "SelectedMusic")!,
                            name: NSLocalizedString("Music", comment: "")),
                        Tag(image: UIImage(named: "Sport")!,
                            selectedImage: UIImage(named: "SelectedSport")!,
                            name: NSLocalizedString("Sport", comment: "")),
                        Tag(image: UIImage(named: "Society")!,
                            selectedImage: UIImage(named: "SelectedSociety")!,
                            name: NSLocalizedString("Society", comment: ""))]
}
