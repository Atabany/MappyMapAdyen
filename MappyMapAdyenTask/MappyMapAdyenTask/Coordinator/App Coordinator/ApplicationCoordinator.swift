//
//  ApplicationCoordinator.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 02/08/2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    var window: UIWindow
    
    var childCoordniators = [Coordinator]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        childCoordniators = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootViewController
    }
    
}
