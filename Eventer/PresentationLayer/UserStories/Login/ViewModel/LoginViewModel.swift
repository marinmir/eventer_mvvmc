//
//  LoginViewModel.swift
//  Eventer
//
//  Created by Yaroslav Magin on 10/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol LoginViewModelInput {
    var userPhone: Binder<String> { get }
    var phoneCode: Binder<String> { get }

    func onSendCodeTap()
    func onAcceptCode()
}

/// Describes view model's output streams needed to update UI
protocol LoginViewModelOutput {
    var canRequestCode: Signal<Bool> { get }
    var showCodeInput: Signal<Bool> { get }
    var showLoading: Signal<Bool> { get }
}

protocol LoginViewModelBindable: LoginViewModelInput & LoginViewModelOutput {}

final class LoginViewModel: LoginModuleInput & LoginModuleOutput {
    var onAuthSuccessful: (() -> Void)?

    private let authData: [String: String] = [
        "+79996912963": "123456",
        "+79996925229": "777777"
    ]

    private let disposeBag = DisposeBag()
    private let phoneNumberRelay = BehaviorRelay<String>(value: "")
    private let phoneCodeRelay = BehaviorRelay<String>(value: "")
    private let canRequestCodeRelay = PublishRelay<Bool>()
    private let showCodeInputRelay = PublishRelay<Bool>()
    private let showLoadingRelay = PublishRelay<Bool>()

    init() {
        phoneNumberRelay
            .map { $0.count == 12 }
            .bind(to: canRequestCodeRelay)
            .disposed(by: disposeBag)

        phoneCodeRelay
            .subscribe(onNext: { code in
                let phone = self.phoneNumberRelay.value

                if self.authData[phone] == code {
                    self.showLoadingRelay.accept(true)

                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.onAuthSuccessful?()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - LoginViewModelBindable implementation

extension LoginViewModel: LoginViewModelBindable {
    var userPhone: Binder<String> {
        return Binder(phoneNumberRelay) { $0.accept($1) }
    }

    var phoneCode: Binder<String> {
        return Binder(phoneCodeRelay) { $0.accept($1) }
    }

    var canRequestCode: Signal<Bool> {
        return canRequestCodeRelay.asSignal()
    }

    var showCodeInput: Signal<Bool> {
        return showCodeInputRelay.asSignal()
    }

    var showLoading: Signal<Bool> {
        return showLoadingRelay.asSignal()
    }

    func onSendCodeTap() {
        showCodeInputRelay.accept(true)
    }

    func onAcceptCode() {

    }
}
