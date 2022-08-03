//
//  NetworkManager.swift
//  CombineNetworkingExample
//
//  Created by Mohamed Elatabany on 03/08/2022.
//

import Foundation
import Combine


/*
 1. setup the network layer base
 2. get the first request in the home
 3. seutp the view model for the home
 4. implement the logic in the controller
 5. implement some tests
 */

class NetworkManager {
    var subscriptions = Set<AnyCancellable>()
    let service = VenusService(networkRequest: NativeRequestable(),
                                  environment: .development)
    func searchVenus(requst: VenusRequest, service: VenusService) {
        service.venusSearch(request: requst)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                print("got my response here \(response)")
            }
            .store(in: &subscriptions)
    }
}
