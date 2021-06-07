//
//  MapViewController.swift
//  Eventer
//
//  Created by Ярослав Магин on 08/01/2021.
//  Copyright © 2021 Marinmir Ltd. All rights reserved.
//

import MapKit
import RxCocoa
import RxSwift
import UIKit

final class MapViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: MapViewModelBindable
    private let disposeBag = DisposeBag()
    private var events: [Event] = []
    private let eventDetails = EventFullSizeCard()
    
    // MARK: - Initializers

    init(viewModel: MapViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        super.loadView()

        let view = MapView()
        view.bind(to: viewModel)

        self.view = view
        
        view.mapDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onViewDidLoad()
        
        viewModel.mapEvents.drive(onNext: { events in
            self.events = events
            (self.view as? MapView)?.showEvents(events)
        }).disposed(by: disposeBag)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let eventAnnotation = view.annotation as? EventAnnotation else {
            return
        }
        // shame, shame, SHAAAAMEEE!!!
        let service = EventsServiceImpl(profileManager: ProfileManagerImpl(recommender: RecommenderImpl(dataSource: RecommenderDataSourceImpl())))
        let eventViewModel = EventCardViewModel(event: eventAnnotation.event, didTapLike: service.toggleFavorite)
        eventDetails.configure(with: eventViewModel)
        
        self.view.addSubview(eventDetails)
        
        eventDetails.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.centerY)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        eventDetails.removeFromSuperview()
    }
}
