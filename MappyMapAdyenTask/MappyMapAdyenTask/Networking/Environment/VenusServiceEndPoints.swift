//
//  venuesPlacesEndPoints.swift
//  CombineNetworkingExample
//
//  Created by Mohamed Elatabany on 12.10.2021.
//

import Foundation

public typealias Headers = [String: String]


enum venuesServiceEndPoints {
    
    struct Credential {
        let clientId : String
        let clientSecret: String
    }
    
    static var credentials: Credential {
        Credential(
            clientId: "ICJ50H0CZJPDFU2FPWKA3LHWXW3ZAWRXCNKDYRIWWVALDASK",
            clientSecret: "O3PQU5HDAD5LQX1CYLWTHG3NSOJ1AL30GALBJWPFIYU4DOZ1"
        )
    }
    
    // organise all the end points here for clarity
    case getvenuesPlaces(request: venuesRequest)
    
    // gave a default timeout but can be different for each
    var requestTimeOut: Int {
        20
    }
    
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = Environment.development.scheme
        urlComponents.host = Environment.development.host
        urlComponents.path = "/v3/places/search"
        return urlComponents
    }

    
    
    // specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .getvenuesPlaces:
            return .GET
        }
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getvenuesPlaces:
            return nil
        }
    }
    
    // compose the NetworkRequest
    func createRequest(environment: Environment, venuesRequest: venuesRequest) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "fsq3huPUxb7GlkVLfEFoI/9xgkKBAjwi6pjCdgigViNAdJ4="
        
        return NetworkRequest(url: getURL(from: environment, request: venuesRequest),
                              headers: headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }
    
    
    
    // compose urls for each request
    func getURL(from environment: Environment, request: venuesRequest) -> URL? {
        
        let paramaters: [String: String] = [
            "ll": request.ll,
            "radius": String(request.radius),
            "limit": String(request.limit),
            "client_id": request.clientID,
            "client_secret": request.clientSecret,
            "v": request.version,
        ]
        
        var urlComponents = self.urlComponents
        urlComponents.setQueryItems(with: paramaters)
        
        switch self {
        case .getvenuesPlaces:
            return urlComponents.url
        }
    }
}


