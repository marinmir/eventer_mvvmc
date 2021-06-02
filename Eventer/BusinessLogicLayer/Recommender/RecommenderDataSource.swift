//
//  RecommenderDataSource.swift
//  Eventer
//
//  Created by Yaroslav Magin on 02.06.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

protocol RecommenderDataSource {
    func startup()
    func getUsers() -> [AppUser]
}
