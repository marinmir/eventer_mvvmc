//
//  EventsDataSource.swift
//  Eventer
//
//  Created by Ярослав Магин on 09.03.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import Foundation
import RxSwift

protocol EventsService {
    var loadedEvents: Observable<[Event]> { get }
    
    func loadEvents() -> Single<[EventType: [Event]]>
}
