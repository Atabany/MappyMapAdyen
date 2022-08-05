//
//  PlacesWorker.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 04/08/2022.
//

import Combine
import MapKit

protocol PlacesWorkerAble {
    func getPlaces()
    var places: CurrentValueSubject<[Place], Never> { get set }
    func setRegion(mapRegion: MKCoordinateRegion)
}

class PlacesWorkerRepo: PlacesWorkerAble {
    
    var places = CurrentValueSubject<[Place], Never>([])
    var cancellAbles = Set<AnyCancellable>()
    
    let venusService: VenusServiceable
    var mapRegion: MKCoordinateRegion?
    
    init(service: VenusServiceable) {
        self.venusService = service
    }
    
    func getPlaces() {
        guard let mapRegion = mapRegion else {
            return
        }

        let venusRequest = VenusRequest(region: mapRegion)
        venusService.venusSearch(request: venusRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    debugPrint("oops got an error \(error.localizedDescription)")
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { response in
                self.places.send(response.results ?? [])
            }
            .store(in: &cancellAbles)
    }
    
    func setRegion(mapRegion: MKCoordinateRegion) {
        self.mapRegion = mapRegion
    }
}
