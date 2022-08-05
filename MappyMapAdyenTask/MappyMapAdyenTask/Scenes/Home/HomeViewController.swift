//
//  ViewController.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit
import MapKit
import Combine

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        return mapView
    }()
    
    lazy var searchButton: CircleButton = {
        let button = CircleButton(backgroundColor: .systemBackground, systemImageName: "magnifyingglass")
        button.addAction(
          UIAction { [weak self] _ in
              self?.viewModel.search()
          }, for: .touchUpInside
        )
        return button
    }()
    
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var cancellables = Set<AnyCancellable>()
    let viewModel: HomeViewModelProtocol
    private var annotations: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        binding()
    }
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Biniding

extension HomeViewController {
    
    private func binding() {
        bindPlaces()
        bindUserLocation()
        bindState()
    }
    
    private func bindPlaces() {
        viewModel
            .places
            .receive(on: DispatchQueue.main)
            .compactMap {
                $0.map { MapKitHelper.createPin(with: $0) }
            }
            .sink { [weak self] in
                guard let self = self else {return}
                self.mapView.removeAnnotations(self.annotations)
                self.annotations = $0
                self.mapView.addAnnotations(self.annotations)
            }
            .store(in: &cancellables)
    }
    
    
    private func bindUserLocation() {
        viewModel
            .userLocation
            .compactMap { $0?.coordinate }
            .map { MKCoordinateRegion(center: $0 , latitudinalMeters: 10000, longitudinalMeters: 10000) }
            .sink { [weak self] in
                self?.viewModel.userDidChangeMap(region: $0)
                self?.mapView.setRegion($0, animated: false)
            }
            .store(in: &cancellables)
    }
    
    private func bindState() {
        viewModel
            .state
            .sink { [weak self] in
                switch $0 {
                case .initial:
                    self?.viewModel.search()
                case .loaded:
                    self?.activityIndicator.stopAnimating()
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .empty(let msg):
                    self?.activityIndicator.stopAnimating()
                    self?.showAlert(msg)
                }
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - Map

extension HomeViewController: MKMapViewDelegate  {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.userDidChangeMap(region: mapView.region)
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        guard let  annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.reuseID.mapAnnotationReuseID) else {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.reuseID.mapAnnotationReuseID)
        }
        annotationView.canShowCallout = true
        return annotationView
    }
        
}


// MARK: - Style & Layout

extension HomeViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        layoutMapView()
        layoutSearchButton()
        layoutActivatiyIndicator()
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
    
    
    private func layoutActivatiyIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}




