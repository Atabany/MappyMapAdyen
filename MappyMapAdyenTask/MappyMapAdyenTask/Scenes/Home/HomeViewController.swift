//
//  ViewController.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit
import MapKit
import Combine


class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    let searchButton: CircleButton = {
        let button = CircleButton(backgroundColor: .systemBackground, systemImageName: "magnifyingglass")
        return button
    }()
    
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        let center = CLLocationCoordinate2D(latitude: 50, longitude: 50)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 50, longitudinalMeters: 50)
//        NetworkManager().
//        NetworkManager().searchVenus(requst: VenusRequest(region: region))
        
        let service = VenusService(networkRequest: NativeRequestable(),
                                      environment: .development)
        
     searchVenus(requst: VenusRequest(region: region), service: service)
    }
    
    func searchVenus(requst: VenusRequest, service: VenusService) {
        service.venusSearch(request: requst)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint("oops got an error \(error.localizedDescription)")
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { (response) in
                debugPrint("got my response here \(response)")
            }
            .store(in: &subscriptions)
    }


}



extension HomeViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        layoutMapView()
        layoutSearchButton()
    }
    
    private func layoutMapView() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func layoutSearchButton() {
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 55),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: searchButton.bottomAnchor, multiplier: 6),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    
}


