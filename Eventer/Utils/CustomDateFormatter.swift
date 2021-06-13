//
//  DateFormmater.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 21.06.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import Foundation

enum CustomDateFormatter {
    // MARK: - Properties
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.locale = .current

        return formatter
    }()

    private static var `default`: DateFormatter {
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }

    private static var shortMonth: DateFormatter {
        dateFormatter.dateFormat = "MMM"
        return dateFormatter
    }

    private static var time: DateFormatter {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }

    // MARK: - Methods
    static func getEventDateString(from date: Date) -> String {
        return CustomDateFormatter.default.string(from: date)
    }

    static func getEventDate(from str: String) -> Date {
        return CustomDateFormatter.default.date(from: str) ?? Date()
    }

    static func getShortMonthName(from date: Date) -> String {
        return CustomDateFormatter.shortMonth.string(from: date)
    }

    static func getTime(from date: Date) -> String {
        return CustomDateFormatter.time.string(from: date)
    }

}
