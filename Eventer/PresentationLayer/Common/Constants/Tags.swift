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
    static let tags = [ Tag(image: Asset.UIKit.TagsImages.art.image,
                            selectedImage: Asset.UIKit.SelectedTagsImages.selectedArt.image,
                            name: L10n.Tags.art),
                        Tag(image: Asset.UIKit.TagsImages.cinema.image,
                            selectedImage: Asset.UIKit.SelectedTagsImages.selectedCinema.image,
                            name: L10n.Tags.cinema),
                        Tag(image: Asset.UIKit.TagsImages.food.image,
                            selectedImage: Asset.UIKit.SelectedTagsImages.selectedFood.image,
                            name: L10n.Tags.food),
                        Tag(image: Asset.UIKit.TagsImages.music.image,
                            selectedImage: Asset.UIKit.SelectedTagsImages.selectedMusic.image,
                            name: L10n.Tags.music),
                        Tag(image: Asset.UIKit.TagsImages.sport.image,
                            selectedImage: Asset.UIKit.SelectedTagsImages.selectedSport.image,
                            name: L10n.Tags.sport),
                        Tag(image: Asset.UIKit.TagsImages.society.image,
                            selectedImage: Asset.UIKit.SelectedTagsImages.selectedSociety.image,
                            name: L10n.Tags.society)]
}
