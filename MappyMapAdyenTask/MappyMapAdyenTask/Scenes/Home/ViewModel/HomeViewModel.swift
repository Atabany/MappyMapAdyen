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
    var userLocation:  CurrentValueSubject<CLLocation?, Never> { get set }
    func userDidChangeMap(region: MKCoordinateRegion)
    func userDidPressSearch()
}


final public class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties & Initialization
    
    var places: CurrentValueSubject<[Place], Never> = CurrentValueSubject<[Place], Never>([])
    var userLocation: CurrentValueSubject<CLLocation?, Never> = CurrentValueSubject<CLLocation?, Never>(nil)
    var cancellables = Set<AnyCancellable>()
    
    private let placesWorkerRepo: PlacesWorkerAble
    private let locationManager: LocationManager
    
    init(placesWorkerRepo: PlacesWorkerAble, locationManager: LocationManager) {
        self.placesWorkerRepo = placesWorkerRepo
        self.locationManager = locationManager
        locationManager.setup()
        bindPlaces()
        bindUserLocation()
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
    
    // MARK: - location
    func bindUserLocation() {
        locationManager
            .$lastLocation
            .sink {[weak self]  in
                self?.userLocation.send($0)
            }
            .store(in: &cancellables)
    }

}
