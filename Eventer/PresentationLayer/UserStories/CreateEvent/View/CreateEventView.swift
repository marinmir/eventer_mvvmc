//
//  CreateEventView.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class CreateEventView: UIView {

    var onImagePickerNeeded: (() -> Void)?
    
    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    private let formTitleLabel = UILabel()
    private let titleTextField = FormInputField()
    private let dateTextField = FormInputField()
    private let costTextField = FormInputField()
    private let titleImageTextField = FormInputField()
    private let locationTextField = FormInputField()
    private let tagsView = TagsInputView()
    private let imageView = UIImageView()
    
    private let buttonContainer = UIView()
    private let btnCreate: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(Asset.Colors.white.color, for: .normal)
        button.backgroundColor = Asset.Colors.darkViolet.color
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        
        
        
        return button
    }()
    
    private let datePicker = UIDatePicker()
    
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

    func updateImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func bind(to viewModel: CreateEventViewModelBindable) {
        viewModel.canCreateEvent
            .drive(onNext: { value in
                self.btnCreate.isEnabled = value
                let titleColor = value ? Asset.Colors.white.color : Asset.Colors.darkViolet.color
                let backgroundColor = value ? Asset.Colors.darkViolet.color : Asset.Colors.lightLavender.color
                self.btnCreate.setTitleColor(titleColor, for: .normal)
                self.btnCreate.backgroundColor = backgroundColor
            })
            .disposed(by: disposeBag)
        
        viewModel.tags.drive(onNext: { tags in
            self.tagsView.setTags(tags)
        }).disposed(by: disposeBag)
        
        viewModel.address.emit(onNext: { address in
            self.locationTextField.textField.text = address
        }).disposed(by: disposeBag)
        
        datePicker.rx.date.subscribe(onNext: { date in
            viewModel.date.onNext(date)
            self.dateTextField.textField.text = CustomDateFormatter.getEventDateString(from: date)
        }).disposed(by: disposeBag)
        
        titleTextField.textField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(titleTextField.textField.rx.text.orEmpty)
            .bind(to: viewModel.title)
            .disposed(by: disposeBag)
        
        costTextField.textField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(costTextField.textField.rx.text.orEmpty)
            .map { Double($0) ?? 0 }
            .bind(to: viewModel.cost)
            .disposed(by: disposeBag)
        
        locationTextField.textField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { _ in
                self.locationTextField.endEditing(true)
                viewModel.onLocationChange()
            }).disposed(by: disposeBag)
        
        titleImageTextField.textField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { _ in
                self.titleImageTextField.endEditing(true)
                
                self.onImagePickerNeeded?()
            })
        
        tagsView.didToggleTag = { tag in
            viewModel.toggleTag(tag)
        }
        
        btnCreate.rx.tap
            .bind(to: viewModel.didTapCreate)
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        addSubview(scroll)
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 16
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        scroll.addSubview(stack)
        
        formTitleLabel.font = .h1
        formTitleLabel.text = L10n.CreateEvent.screenTitle
        formTitleLabel.textAlignment = .center
        stack.addArrangedSubview(formTitleLabel)
        
        titleTextField.titleLabel.text = L10n.CreateEvent.title
        titleTextField.textField.autocapitalizationType = .words
        titleTextField.textField.placeholder = L10n.CreateEvent.title
        stack.addArrangedSubview(titleTextField)
        
        datePicker.datePickerMode = .dateAndTime
        dateTextField.titleLabel.text = L10n.CreateEvent.date
        dateTextField.textField.inputView = datePicker
        dateTextField.textField.placeholder = L10n.CreateEvent.date
        stack.addArrangedSubview(dateTextField)
        
        costTextField.textField.keyboardType = .decimalPad
        costTextField.textField.placeholder = L10n.CreateEvent.cost
        costTextField.titleLabel.text = L10n.CreateEvent.cost
        stack.addArrangedSubview(costTextField)
        
        titleImageTextField.titleLabel.text = L10n.CreateEvent.image
        titleImageTextField.textField.placeholder = L10n.CreateEvent.image
        stack.addArrangedSubview(titleImageTextField)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        titleImageTextField.addSubview(imageView)
        
        locationTextField.titleLabel.text = L10n.CreateEvent.location
        stack.addArrangedSubview(locationTextField)
        
        stack.addArrangedSubview(tagsView)
        
        btnCreate.setTitle(L10n.CreateEvent.create, for: .normal)
        buttonContainer.addSubview(btnCreate)
        stack.addArrangedSubview(buttonContainer)
    }
    
    private func setConstraints() {
        scroll.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        stack.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
            make.width.equalTo(self)
        }
        
        formTitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        dateTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        costTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        titleImageTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        tagsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        btnCreate.snp.makeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
            make.width.equalTo(160)
        }
    }
}

