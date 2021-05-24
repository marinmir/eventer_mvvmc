//
//  PickLocationView.swift
//  Eventer
//
//  Created by Ярослав Магин on 25/05/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import MapKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class PickLocationView: UIView {

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let mapView = MKMapView()

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

    func bind(to viewModel: PickLocationViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }

    // MARK: - Private methods

    @objc private func onMapTap(sender: UITapGestureRecognizer) {
        if sender.state != .ended {
            return
        }
        
        let touch = sender.location(in: mapView)
        let coords = mapView.convert(touch, toCoordinateFrom: mapView)
        print(coords)
    }
    
    private func setupViews() {
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMapTap(sender:))))
        addSubview(mapView)
    }

    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
