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
    var state: CurrentValueSubject<State, Never> { get set }
    func userDidChangeMap(region: MKCoordinateRegion)
    func search()
}

enum State {
    case initial
    case loading
    case loaded
    case empty
}

final public class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties & Initialization
    
    var places: CurrentValueSubject<[Place], Never> = CurrentValueSubject<[Place], Never>([])
    var userLocation: CurrentValueSubject<CLLocation?, Never> = CurrentValueSubject<CLLocation?, Never>(nil)
    var state: CurrentValueSubject<State, Never> = CurrentValueSubject<State, Never>(.initial)
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
                self?.state.value = $0.isEmpty ? .empty : .loaded
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - User Actions
    
    func userDidChangeMap(region: MKCoordinateRegion) {
        placesWorkerRepo.setRegion(mapRegion: region)
    }
    
    func search() {
        self.state.value = .loading
        placesWorkerRepo.getPlaces()
    }
    
    // MARK: - location
    func bindUserLocation() {
        locationManager
            .$lastLocation
            .removeDuplicates()
            .sink {[weak self]  in
                self?.userLocation.send($0)
                self?.search()
            }
            .store(in: &cancellables)
    }

}
