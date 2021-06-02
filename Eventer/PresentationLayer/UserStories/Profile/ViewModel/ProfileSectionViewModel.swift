//
//  ProfileSectionViewModel.swift
//  Eventer
//
//  Created by Yaroslav Magin on 01.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

enum ProfileSectionItemViewModel {
    case plain(text: String, details: String?)
    case logout
}

enum ProfileSectionViewModel {
    case avatar(AvatarViewModel)
    case items([ProfileSectionItemViewModel])
}
