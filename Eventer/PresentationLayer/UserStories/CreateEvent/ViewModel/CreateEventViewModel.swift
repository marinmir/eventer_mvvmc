//
//  CreateEventViewModel.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

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
    
    func toggleTag(_ tagViewModel: TagViewModel)
    func onLocationChange()
}

/// Describes view model's output streams needed to update UI
protocol CreateEventViewModelOutput {
    var tags: Driver<[TagViewModel]> { get }
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
    private let tapCreateRelay = PublishRelay<Void>()
    private let tagsRelay = BehaviorRelay<[TagViewModel]>(value: Tags.tags.map { TagViewModel(tag: $0) })
    
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
