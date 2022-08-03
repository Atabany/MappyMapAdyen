//
//  Environment.swift
//  CombineNetworkingExample
//
//  Created by Mohamed Elatabany on 03/08/2022.
//

import Foundation

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    
    var apiKey: String {
        return  "fsq3huPUxb7GlkVLfEFoI/9xgkKBAjwi6pjCdgigViNAdJ4="
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.foursquare.com"
    }
    
    var version: String {
        switch self {
        case .development:
            return "20190803"
        case .staging:
            return "20190803"
        case .production:
            return "20190803"
        }
        
    }
}
