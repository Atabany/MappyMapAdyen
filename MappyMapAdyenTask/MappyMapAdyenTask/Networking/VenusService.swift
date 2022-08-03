//
//  PurchaseService.swift
//  CombineNetworkingExample
//
//  Created by Mohamed Elatabany on 03/08/2022.
//

import Foundation
import Combine
import MapKit

protocol VenusServiceable {
    func venusSearch(request: VenusRequest) -> AnyPublisher<VenusResponse, NetworkError>
}

class VenusService: VenusServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func venusSearch(request: VenusRequest) -> AnyPublisher<VenusResponse, NetworkError> {
        let endpoint = VenusServiceEndPoints.getVenusPlaces(request: request)
        let request = endpoint.createRequest(environment: environment, venusRequest: request)
        return networkRequest.request(request)
    }
}

public struct VenusRequest: Encodable {
    public let ll: String
    public let radius: Int
    public let limit: Int
    public let clientID: String
    public let clientSecret: String
    public let version: String

    
    init(credintials: VenusServiceEndPoints.Credential = VenusServiceEndPoints.credentials, limit: Int = 50, version: String = Environment.development.version, region: MKCoordinateRegion) {
        self.clientID = credintials.clientId
        self.clientSecret = credintials.clientSecret
        self.version = version
        self.limit = limit
        self.ll = "\(region.center.latitude),\(region.center.longitude)"
        self.radius = VenusRequest.getRadius(with: region)
    }
    
    
    
    static func getRadius(with region: MKCoordinateRegion) -> Int {
        let center = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        let delta = region.span.latitudeDelta
        let coordinate1 = CLLocation(latitude: center.coordinate.latitude + delta/2, longitude: center.coordinate.longitude)
        let radius = center.distance(from: coordinate1)
        return min(Int(radius), 100_000)
    }

}





