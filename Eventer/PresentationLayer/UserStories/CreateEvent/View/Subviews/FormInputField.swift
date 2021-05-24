//
//  FormInputField.swift
//  Eventer
//
//  Created by Ярослав Магин on 24.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

final class FormInputField: UIView {
    let titleLabel = UILabel()
    let textField = UITextField()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.font = .h2
        titleLabel.textColor = Asset.Colors.black.color
        addSubview(titleLabel)
        
        addSubview(textField)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalTo(textField.snp.top)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
