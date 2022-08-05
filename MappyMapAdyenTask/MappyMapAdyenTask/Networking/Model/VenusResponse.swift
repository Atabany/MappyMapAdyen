//
//  venuesResponse.swift
//  CombineNetworkingExample
//
//  Created by Mohamed Elatabany on 03/08/2022.
//

import Foundation

// MARK: - venuesResponse
struct venuesResponse: Codable {
    let results: [Place]?
    let context: Context?
}

// MARK: - Context
struct Context: Codable {
    let geoBounds: GeoBounds?

    enum CodingKeys: String, CodingKey {
        case geoBounds = "geo_bounds"
    }
}

// MARK: - GeoBounds
struct GeoBounds: Codable {
    let circle: Circle?
}

// MARK: - Circle
struct Circle: Codable {
    let center: Center?
    let radius: Int?
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Result
struct Place: Codable {
    let fsqID: String?
    let categories: [Category]?
    let chains: [Chain]?
    let distance: Int?
    let geocodes: Geocodes?
    let link: String?
    let location: Location?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case categories, chains, distance, geocodes, link, location, name
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
    let icon: Icon?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Chain
struct Chain: Codable {
    let id, name: String?
}

// MARK: - Geocodes
struct Geocodes: Codable {
    let main: Center?
    let roof: Center?
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let country: String?
    let formattedAddress: String?
    let locality: String?
    let neighborhood: [String]?
    let region: String?
    let postTown: String?

    enum CodingKeys: String, CodingKey {
        case address, country
        case formattedAddress = "formatted_address"
        case locality, neighborhood, region
        case postTown = "post_town"
    }
}

