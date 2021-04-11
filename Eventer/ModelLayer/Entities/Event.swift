//
//  Event.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 21.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

struct Event: Codable {
    // MARK: - Properties
    var id: String?
    var title: String?
    var place: String?
    var dateTime: Date?
    var cost: Double?
    var description: String?
    var titleImage: String?
    var visitors: Visitors?

}
