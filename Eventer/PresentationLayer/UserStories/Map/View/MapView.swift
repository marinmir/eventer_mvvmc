//
//  MapView.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import RxCocoa
import RxSwift
import MapKit
import SnapKit
import UIKit

final class MapView: UIView {

    var mapDelegate: MKMapViewDelegate? {
        get {
            return mapView.delegate
        }
        
        set {
            mapView.delegate = newValue
        }
    }
    
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

    func showEvents(_ events: [Event]) {
        let annotations = events.map { EventAnnotation(event: $0) }
        mapView.addAnnotations(annotations)
    }
    
    func bind(to viewModel: MapViewModelBindable) {
        viewModel.userLocation.drive(onNext: { location in
            self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        mapView.showsUserLocation = true
        addSubview(mapView)
    }
    
    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
