//
//  FeedFiltersViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 01/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum FiltersSection {
    case location([BubbleViewModel])
    case date([BubbleViewModel])
    case timeOfDay([BubbleViewModel])
    case price(Double?, Double?)
}

/// Describes view model's input streams/single methods
protocol FeedFiltersViewModelInput {
    var didTapReset: Binder<Void> { get }
    var didTapApply: Binder<Void> { get }
    
    func onDisappear()
}

/// Describes view model's output streams needed to update UI
protocol FeedFiltersViewModelOutput {
    var filtersSections: Driver<[FiltersSection]> { get }
}

protocol FeedFiltersViewModelBindable: FeedFiltersViewModelInput & FeedFiltersViewModelOutput {}

final class FeedFiltersViewModel: FeedFiltersModuleInput & FeedFiltersModuleOutput {
    var onComplete: (([FeedFilter]) -> Void)?
    var onCancelled: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    private var filters: [FeedFilter]
    private let filtersRelay = BehaviorRelay<[FiltersSection]>(value: [])
    private let resetRelay = PublishRelay<Void>()
    private let applyRelay = PublishRelay<Void>()
    
    init(initialFilters: [FeedFilter]) {
        filters = initialFilters
        
        filtersRelay.accept([
            prepareLocationFilter(),
            prepareDateFilter(),
            prepareTimeOfDayFilter(),
            preparePriceFilter()
        ])
    }
    
    private func prepareLocationFilter() -> FiltersSection {
        let currentLocationBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.Location.current)
        let otherLocationBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.Location.other)
        
        if let initialValue = filters.first(where: { value in
            switch value {
                case .location:
                    return true
                default: return false
            }
        }) {
            switch initialValue {
                case .location(let type):
                    switch type {
                        case .current:
                            currentLocationBubble.isSelected = true
                        default:
                            otherLocationBubble.isSelected = true
                    }
                default:
                    break
            }
        } else {
            filters.insert(.location(.current), at: 0)
            currentLocationBubble.isSelected = true
        }
        
        return .location([currentLocationBubble, otherLocationBubble])
    }
    
    private func prepareDateFilter() -> FiltersSection {
        let todayBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.Date.today)
        let tomorrowBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.Date.tomorrow)
        let thisWeekBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.Date.thisWeek)
        let chooseDataBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.Date.choose)
        
        let today = Date()
        let tomorrow = today.addingTimeInterval(86400)
        
        if let initialValue = filters.first(where: { value in
            switch value {
                case .date:
                    return true
                default:
                    return false
            }
        }) {
            switch initialValue {
                case .date(let start, let end):
                    if start != nil && start == end {
                        
                        if Calendar.current.component(.day, from: start!) == Calendar.current.component(.day, from: today) &&
                            Calendar.current.component(.month, from: start!) == Calendar.current.component(.month, from: today) {
                            todayBubble.isSelected = true
                        } else if Calendar.current.component(.day, from: start!) == Calendar.current.component(.day, from: tomorrow) &&
                                    Calendar.current.component(.month, from: start!) == Calendar.current.component(.month, from: tomorrow) {
                            tomorrowBubble.isSelected = true
                        }
                    } else if start != nil && end != nil {
                        thisWeekBubble.isSelected = true
                    } else {
                        chooseDataBubble.isSelected = true
                    }
                default:
                    break
            }
        } else {
            filters.insert(.date(start: today, end: today), at: 1)
            todayBubble.isSelected = true
        }
        
        return .date([todayBubble, tomorrowBubble, thisWeekBubble, chooseDataBubble])
    }
    
    private func prepareTimeOfDayFilter() -> FiltersSection {
        let morningBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.TimeOfDay.morning)
        let dayBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.TimeOfDay.day)
        let eveningBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.TimeOfDay.evening)
        let nightBubble = BubbleViewModel(image: nil, selectedImage: nil, text: L10n.Filter.TimeOfDay.night)
        
        if let initialValue = filters.first(where: { value in
            switch value {
                case .timeOfDay:
                    return true
                default:
                    return false
            }
        }) {
            switch initialValue {
                case .timeOfDay(let timeOfDay):
                    switch timeOfDay {
                        case .morning:
                            morningBubble.isSelected = true
                        case .day:
                            dayBubble.isSelected = true
                        case .evening:
                            eveningBubble.isSelected = true
                        case .night:
                            nightBubble.isSelected = true
                    }
                default:
                    break
            }
        } else {
            filters.insert(.timeOfDay(.evening), at: 2)
            eveningBubble.isSelected = true
        }
        
        return .timeOfDay([morningBubble, dayBubble, eveningBubble, nightBubble])
    }
    
    private func preparePriceFilter() -> FiltersSection {
        if let initialValue = filters.first(where: { value in
            switch value {
                case .price:
                    return true
                default:
                    return false
            }
        }) {
            switch initialValue {
                case .price(let start, let end):
                    return .price(start, end)
                default:
                    return .price(nil, nil)
            }
        } else {
            filters.insert(.price(start: nil, end: nil), at: 3)
            return .price(nil, nil)
        }
    }
}

// MARK: - FeedFiltersViewModelBindable implementation

extension FeedFiltersViewModel: FeedFiltersViewModelBindable {
    var didTapApply: Binder<Void> {
        return Binder(applyRelay) { $0.accept($1) }
    }
    
    var didTapReset: Binder<Void> {
        return Binder(resetRelay) { $0.accept($1) }
    }
    
    var filtersSections: Driver<[FiltersSection]> {
        return filtersRelay.asDriver()
    }
    
    func onDisappear() {
        onCancelled?()
    }
}
