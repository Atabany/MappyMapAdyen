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
    let viewModel: HomeViewModelProtocol
    
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
        viewModel.places
            .receive(on: DispatchQueue.main)
            .sink {
                print($0)
            }
            .store(in: &subscriptions)
        
    }
    
}

// MARK: - Map

extension HomeViewController {
    
    
}


// MARK: - Style & Layout

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

