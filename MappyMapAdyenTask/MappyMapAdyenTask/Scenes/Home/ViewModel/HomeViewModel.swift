//
//  HomeViewModel.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 04/08/2022.
//

import Foundation
import MapKit
import Combine

protocol HomeViewModelProtocol {
    var places: CurrentValueSubject<[Place], Never> { get set }
    var didLoadPlaces: (CallBack<[Place]>)? { get set }
    var updateUserLocation: ((CLLocation) -> Void)? { get set }
    func userDidChangeMap(region: MKCoordinateRegion)
}


final public class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties & Initialization
    
    var places: CurrentValueSubject<[Place], Never> = CurrentValueSubject<[Place], Never>([])
    
    var didLoadPlaces: (CallBack<[Place]>)?
    
    var updateUserLocation: ((CLLocation) -> Void)?
    var cancellables = Set<AnyCancellable>()
    
    private let placesWorkerRepo: PlacesWorkerAble
    private let locationManager: LocationManager
    init(placesWorkerRepo: PlacesWorkerAble, locationManager: LocationManager) {
        self.placesWorkerRepo = placesWorkerRepo
        self.locationManager = locationManager
        bindPlaces()
    }
    
    
    // MARK: - Binding
    
    private func bindPlaces() {
        placesWorkerRepo.places
            .sink { [weak self] in
                self?.places.send($0)
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - User Actions
    
    func userDidChangeMap(region: MKCoordinateRegion) {
        placesWorkerRepo.setRegion(mapRegion: region)
    }
    
    
    func userDidPressSearch() {
        placesWorkerRepo.getPlaces()
    }
}
