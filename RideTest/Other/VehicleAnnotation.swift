//
//  Artwork.swift
//  RideTest
//
//  Created by Paritosh_raval on 21/07/21.
//

import Foundation
import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    let id: Int
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(
        id: Int,
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.id = id
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
