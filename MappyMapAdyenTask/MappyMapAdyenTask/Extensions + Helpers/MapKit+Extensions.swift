//
//  MapKit+Extensions.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 05/08/2022.
//

import UIKit
import MapKit

public class MapAnnotation: MKPointAnnotation {
    var id: String?
}

struct MapKitHelper  {
    static func createPin(with place: Place) -> MKPointAnnotation {
        let annotation = MapAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.geocodes?.main?.latitude ?? 0, longitude: place.geocodes?.main?.longitude ?? 0)
        annotation.title = place.name
        annotation.subtitle = place.categories?.first?.name ?? ""
        annotation.id = place.fsqID ?? ""
        return annotation
    }
}
