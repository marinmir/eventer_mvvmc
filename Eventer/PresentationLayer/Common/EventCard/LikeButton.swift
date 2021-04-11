//
//  LikeButton.swift
//  Eventer
//
//  Created by Ярослав Магин on 11.04.2021.
//  Copyright © 2021 Мирошниченко Марина. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class LikeButton: UIButton {
    // MARK: - Nested types
    
    private enum Constants {
        static let buttonSide: CGFloat = 35
        static let contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    // MARK: - Public properties
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.backgroundColor = Asset.Colors.lightLavender.color
                self.backgroundColor = .clear
            }
        }
    }
    
    var didTap: Signal<Void> {
        return rx.tap
            .asSignal()
            .throttle(.milliseconds(200))
            .do(onNext: {
                self.isSelected.toggle()
            })
    }
    
    // MARK: - Private properties
    
    //private let didTapRelay = PublishRelay<Void>()
    //private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        setImage(Asset.UIKit.LikeButton.likeButton.image, for: .normal)
        setImage(Asset.UIKit.LikeButton.selectedLikeButton.image, for: .selected)
        layer.cornerRadius = Constants.buttonSide/2
        contentEdgeInsets = Constants.contentInsets
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.buttonSide),
            heightAnchor.constraint(equalToConstant: Constants.buttonSide)
        ])
    }
}
