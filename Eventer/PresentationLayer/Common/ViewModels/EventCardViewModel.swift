//
//  EventCardViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 19.04.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation

final class EventCardViewModel {
    // MARK: - Public properties
    var title: String {
        return event.title ?? ""
    }
    
    var titleImage: String? {
        return event.titleImage
    }
    
    var date: String {
        guard let date = event.dateTime else {
            return ""
        }
        
        return dateFormatter.string(from: date)
    }
    
    var location: String {
        return event.place ?? ""
    }
    
    var eventDescription: String {
        return event.description ?? ""
    }
    
    var price: String {
        if let price = event.cost {
            return String(format: "%d.2f", price)
        } else {
            return L10n.Event.free
        }
    }
    
    var visitorsPreviewText: String {
        if let visitors = event.visitors {
            return L10n.Event.going(visitors.visitorsCount)
        } else {
            return L10n.Event.noVisitors
        }
    }
    
    var visitorsPreview: Visitors? {
        return event.visitors
    }
    
    // MARK: - Private properties
    private let event: Event
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMMM dd, yyyy"
        
        return dateFormatter
    }()
    
    // MARK: - Initializers
    
    init(event: Event) {
        self.event = event
        
    }
}
