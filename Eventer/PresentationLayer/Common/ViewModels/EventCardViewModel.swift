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
    var didTapLike: ((Event) -> Void)?
    var didTapParticipate: ((Event) -> Void)?
    
    var title: String {
        return event.title ?? ""
    }
    
    var titleImage: String? {
        return event.titleImage
    }
    
    var pureDate: Date {
        return event.dateTime ?? Date()
    }
    
    var date: String {
        guard let date = event.dateTime else {
            return ""
        }
        
        return dateFormatter.string(from: date)
    }
    
    var time: String {
        guard let date = event.dateTime else {
            return ""
        }
        
        return CustomDateFormatter.getTime(from: date)
    }
    
    var location: String {
        return event.place ?? ""
    }
    
    var eventDescription: String {
        return event.description ?? ""
    }
    
    var price: String {
        if let price = event.cost {
            return String(format: "%.2f ₽", price)
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
    
    let event: Event
    var isFavorite: Bool
    // MARK: - Private properties
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMMM dd, yyyy"
        
        return dateFormatter
    }()
    
    // MARK: - Initializers
    
    init(event: Event, isFavorite: Bool, didTapLike: ((Event) -> Void)?, didTapParticipate: ((Event) -> Void)?) {
        self.event = event
        self.didTapLike = didTapLike
        self.didTapParticipate = didTapParticipate
        self.isFavorite = isFavorite
    }
    
    func onTapLike() {
        didTapLike?(event)
    }
    
    func onTapParticipate() {
        didTapParticipate?(event)
    }
}
