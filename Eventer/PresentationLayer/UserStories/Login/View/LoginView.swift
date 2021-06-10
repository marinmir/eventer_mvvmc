//
//  LoginView.swift
//  Eventer
//
//  Created by Yaroslav Magin on 10/06/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class LoginView: UIView {

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    private let phoneTextField: UITextField = {
        let textField = UITextField()

        textField.keyboardType = .phonePad
        textField.placeholder = L10n.Login.phone
        textField.textAlignment = .center

        return textField
    }()

    private let phoneCodeTextField: UITextField = {
        let textField = UITextField()

        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.alpha = 0
        textField.textAlignment = .center

        return textField
    }()

    private let sendCodeButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitleColor(Asset.Colors.darkViolet.color, for: .normal)
        button.backgroundColor = Asset.Colors.lightLavender.color
        button.setTitle(L10n.Login.sendCode, for: .normal)
        button.setTitle(L10n.Login.sendCode, for: .selected)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16

        return button
    }()

    private let skipButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle(L10n.Login.skip, for: .normal)
        button.setTitleColor(.white, for: .normal)

        return button
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)

        indicator.hidesWhenStopped = true
        indicator.isHidden = true

        return indicator
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupViews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: LoginViewModelBindable) {
        phoneTextField.rx.text.orEmpty.bind(to: viewModel.userPhone)
            .disposed(by: disposeBag)
        phoneCodeTextField.rx.text.orEmpty.bind(to: viewModel.phoneCode)
            .disposed(by: disposeBag)

        sendCodeButton.rx.tap.bind(onNext: { _ in
            viewModel.onSendCodeTap()
        }).disposed(by: disposeBag)

        viewModel.showCodeInput.emit(onNext: { _ in
            UIView.animate(withDuration: 1) {
                self.phoneCodeTextField.alpha = 1.0
            }
        }).disposed(by: disposeBag)

        viewModel.canRequestCode.emit(onNext: { canRequest in
            self.sendCodeButton.isEnabled = canRequest

            if canRequest {
                self.sendCodeButton.backgroundColor = Asset.Colors.darkViolet.color
                self.sendCodeButton.setTitleColor(Asset.Colors.white.color, for: .normal)
            } else {
                self.sendCodeButton.backgroundColor = Asset.Colors.lightLavender.color
                self.sendCodeButton.setTitleColor(Asset.Colors.darkViolet.color, for: .normal)
            }
        }).disposed(by: disposeBag)

        viewModel.showLoading.emit(onNext: { value in
            self.activityIndicator.isHidden = !value
            if value {
                self.activityIndicator.startAnimating()
            }
        }).disposed(by: disposeBag)
    }

    // MARK: - Private methods

    @objc private func onBackgroundTap() {
        endEditing(true)
    }

    private func setGradientBackground() {
        let colorTop =  Asset.Colors.darkViolet.color.cgColor
        let colorMiddle = Asset.Colors.lightLavender.color.cgColor
        let colorBottom = Asset.Colors.white.color

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMiddle, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = UIScreen.main.bounds

        layer.insertSublayer(gradientLayer, at:0)
    }

    private func setupViews() {
        setGradientBackground()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackgroundTap)))

        addSubview(phoneTextField)
        addSubview(phoneCodeTextField)
        addSubview(sendCodeButton)
        addSubview(activityIndicator)
        addSubview(skipButton)
    }

    private func setConstraints() {
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(44)
        }

        sendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(24)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }

        phoneCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(sendCodeButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(44)
        }
    }
}
