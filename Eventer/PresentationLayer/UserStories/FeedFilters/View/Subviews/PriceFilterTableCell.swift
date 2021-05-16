//
//  PriceFilterTableCell.swift
//  Eventer
//
//  Created by Ярослав Магин on 16.05.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import SnapKit
import UIKit

final class PriceFilterTableCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PriceFilterTableCell.self)
    
    private let lowPriceTextField = UITextField()
    private let upperPriceTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: PriceFilterTableCell.reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: FiltersSection) {
        switch data {
            case .price(let low, let upper):
                lowPriceTextField.text = low == nil ? nil : String(low!)
                upperPriceTextField.text = upper == nil ? nil : String(upper!)
            default:
                break
        }
    }
    
    private func setupViews() {
        
        lowPriceTextField.tintColor = Asset.Colors.darkViolet.color
        lowPriceTextField.placeholder = L10n.Filter.Price.from
        
        upperPriceTextField.tintColor = Asset.Colors.darkViolet.color
        upperPriceTextField.placeholder = L10n.Filter.Price.to
        
        contentView.addSubview(lowPriceTextField)
        contentView.addSubview(upperPriceTextField)
    }
    
    private func setConstraints() {
        lowPriceTextField.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview().inset(16)
            make.width.equalTo(120)
            make.height.equalTo(44)
        }
        
        upperPriceTextField.snp.makeConstraints { make in
            make.trailing.bottom.top.equalToSuperview().inset(16)
            make.width.equalTo(120)
            make.height.equalTo(44)
        }
    }
}
