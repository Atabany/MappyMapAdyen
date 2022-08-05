//
//  HomeCoordinator.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    
    init() {
        rootViewController = UIViewController()
    }
    
    lazy var homeViewController: HomeViewController = {
        let venuesService = venuesService(networkRequest: NativeRequestable(), environment: .development)
        let viewModel = HomeViewModel(placesWorkerRepo: PlacesWorkerRepo(service: venuesService), locationManager: LocationManager())
        let vc = HomeViewController(viewModel: viewModel)
        vc.title = "Home"
        return vc
    }()

    

    func start() {
        rootViewController = homeViewController
    }
    
    
}
