//
//  CreateEventViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol CreateEventViewModelInput {
    var title: Binder<String> { get }
    var date: Binder<Date> { get }
    var time: Binder<Date> { get }
    var cost: Binder<Double> { get }
    var image: Binder<UIImage> { get }
    var didTapCreate: Binder<Void> { get }
    var location: Binder<PickedPinViewModel> { get }
    
    func toggleTag(_ tagViewModel: TagViewModel)
    func onLocationChange()
}

/// Describes view model's output streams needed to update UI
protocol CreateEventViewModelOutput {
    var tags: Driver<[TagViewModel]> { get }
    var address: Signal<String> { get }
    var canCreateEvent: Driver<Bool> { get }
    var createdEvent: Signal<Void> { get }
}

protocol CreateEventViewModelBindable: CreateEventViewModelInput & CreateEventViewModelOutput {}

final class CreateEventViewModel: CreateEventModuleInput & CreateEventModuleOutput {
    var onLocationChangeRequested: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    private let titleRelay = PublishRelay<String>()
    private let dateRelay = PublishRelay<Date>()
    private let timeRelay = PublishRelay<Date>()
    private let costRelay = PublishRelay<Double>()
    private let imageRelay = PublishRelay<UIImage>()
    private let locationRelay = PublishRelay<PickedPinViewModel>()
    private let addressRelay = PublishRelay<String>()
    private let tapCreateRelay = PublishRelay<Void>()
    private let canCreateEventRelay = BehaviorRelay<Bool>(value: false)
    private let createdEventRelay = PublishRelay<Void>()
    private let tagsRelay = BehaviorRelay<[TagViewModel]>(value: Tags.tags.map { TagViewModel(tag: $0) })
    
    private let eventsService: EventsService
    
    init(eventsService: EventsService) {
        self.eventsService = eventsService
        
        locationRelay
            .map({$0.address ?? ""})
            .filter({!$0.isEmpty})
            .bind(to: addressRelay)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(titleRelay.asObservable(),
                                 dateRelay.asObservable(),
                                 costRelay.asObservable(),
                                 imageRelay.asObservable(),
                                 locationRelay.asObservable()
        ).subscribe(onNext: { title, date, cost, image, location in
            self.canCreateEventRelay.accept(true)
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(titleRelay.asObservable(),
                                 dateRelay.asObservable(),
                                 costRelay.asObservable(),
                                 imageRelay.asObservable(),
                                 locationRelay.asObservable(),
                                 tapCreateRelay.asObservable()
        ).subscribe(onNext: { title, date, cost, image, location, _ in
            self.eventsService.createEvent(
                with: title,
                image: image,
                location: location,
                date: date,
                cost: cost,
                tags: []
            ).subscribe(onCompleted: {
                self.createdEventRelay.accept(())
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
}

// MARK: - CreateEventViewModelBindable implementation

extension CreateEventViewModel: CreateEventViewModelBindable {
    var title: Binder<String> {
        return Binder(titleRelay) { $0.accept($1) }
    }
    
    var date: Binder<Date> {
        return Binder(dateRelay) { $0.accept($1) }
    }
    
    var time: Binder<Date> {
        return Binder(timeRelay) { $0.accept($1) }
    }
    
    var cost: Binder<Double> {
        return Binder(costRelay) { $0.accept($1) }
    }
    
    var image: Binder<UIImage> {
        return Binder(imageRelay) { $0.accept($1) }
    }
    
    var location: Binder<PickedPinViewModel> {
        return Binder(locationRelay) { $0.accept($1)}
    }
    
    var address: Signal<String> {
        return addressRelay.asSignal()
    }
    
    var canCreateEvent: Driver<Bool> {
        return canCreateEventRelay.asDriver()
    }
    
    var createdEvent: Signal<Void> {
        return createdEventRelay.asSignal()
    }
    
    var tags: Driver<[TagViewModel]> {
        return tagsRelay.asDriver()
    }
    
    var didTapCreate: Binder<Void> {
        return Binder(tapCreateRelay) { $0.accept($1) }
    }
    
    func toggleTag(_ tagViewModel: TagViewModel) {
        
    }
    
    func onLocationChange() {
        onLocationChangeRequested?()
    }
    
    func onCreateButton() {
        
    }
}
