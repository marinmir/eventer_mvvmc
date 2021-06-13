//
//  Event.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 21.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

enum SingleEventType {
    case `public`
    case `private`
}

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
    var rawType: Int?
    var tags: [String]?
    var location: EventLocation

    var type: SingleEventType {
        switch rawType {
        case 1:
            return .private
        default:
            return .public
        }
    }
}

extension Event: Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? "")
    }
}
