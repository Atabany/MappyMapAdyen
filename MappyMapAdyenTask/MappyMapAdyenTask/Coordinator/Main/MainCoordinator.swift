//
//  MainCoordinator.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    
    
    var rootViewController: UINavigationController

    var childCoordinators = [Coordinator]()
    
    
    init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    
    func start() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
        rootViewController.viewControllers = [homeCoordinator.rootViewController]
    }
    
    
    
}
