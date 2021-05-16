//
//  TimeOfDay.swift
//  Eventer
//
//  Created by Ярослав Магин on 02.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

enum TimeOfDay {
    case morning
    case day
    case evening
    case night
    
    static func from(date: Date) -> TimeOfDay {
        let hour = Calendar.current.component(.hour, from: date)
        
        switch hour {
            case 0..<5:
                return .night
            case 5..<12:
                return .morning
            case 12..<18:
                return .day
            case 18..<23:
                return .evening
            default:
                return .night
        }
    }
}
