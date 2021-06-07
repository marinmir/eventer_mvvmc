//
//  AppUser.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

struct AppUser: Decodable {
    let id: String?
    let my: [Event]?
    let participateIn: [Event]?
    let favorites: [Event]?
}
