//
//  PurchaseService.swift
//  CombineNetworkingExample
//
//  Created by Mohamed Elatabany on 03/08/2022.
//

import Foundation
import Combine
import MapKit

protocol venuesServiceable {
    func venuesSearch(request: venuesRequest) -> AnyPublisher<venuesResponse, NetworkError>
}

class venuesService: venuesServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func venuesSearch(request: venuesRequest) -> AnyPublisher<venuesResponse, NetworkError> {
        let endpoint = venuesServiceEndPoints.getvenuesPlaces(request: request)
        let request = endpoint.createRequest(environment: environment, venuesRequest: request)
        return networkRequest.request(request)
    }
}

public struct venuesRequest: Encodable {
    public let ll: String
    public let radius: Int
    public let limit: Int
    public let clientID: String
    public let clientSecret: String
    public let version: String

    
    init(credintials: venuesServiceEndPoints.Credential = venuesServiceEndPoints.credentials, limit: Int = 50, version: String = Environment.development.version, region: MKCoordinateRegion) {
        self.clientID = credintials.clientId
        self.clientSecret = credintials.clientSecret
        self.version = version
        self.limit = limit
        self.ll = "\(region.center.latitude),\(region.center.longitude)"
        self.radius = venuesRequest.getRadius(with: region)
    }
    
    
    
    static func getRadius(with region: MKCoordinateRegion) -> Int {
        let center = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        let delta = region.span.latitudeDelta
        let coordinate1 = CLLocation(latitude: center.coordinate.latitude + delta/2, longitude: center.coordinate.longitude)
        let radius = center.distance(from: coordinate1)
        return min(Int(radius), 100_000)
    }

}





