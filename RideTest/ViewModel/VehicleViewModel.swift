//
//  VehicleViewModel.swift
//  RideTest
//
//  Created by Paritosh_raval on 21/07/21.
//

import Foundation
import MapKit

protocol VehicleViewModelDelegate {
    func vehiclesFound()
    func noVehiclesFound()
}

class VehicleViewModel {
    
    var vehicles = [Vehicle]()
    var delegate: VehicleViewModelDelegate?
    
    func getVehicleData() {
        let jsonParser = VehicleParser()
        if let parsedData = jsonParser.parseJson(fileName: "Vehicles") {
            vehicles = parsedData
            delegate?.vehiclesFound()
        } else {
            delegate?.noVehiclesFound()
        }
    }
    
    func getLocationArray() -> [VehicleAnnotation] {
        var locationArray = [VehicleAnnotation]()
        for item in vehicles {
            if let lat = item.lat, let lng = item.lng {
                let artwork = VehicleAnnotation(
                    id: item.id,
                    title: item.title,
                    locationName: "San Fransisco",
                    coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                locationArray.append(artwork)
            }
        }
        return locationArray
    }
    
    
    func getVehicle(for indexPath: IndexPath) -> Vehicle {
        return vehicles[indexPath.row]
    }
    
    func getIndexPathFor(annotationView: MKAnnotationView) -> IndexPath {
        let index = vehicles.firstIndex{ $0.id == annotationView.tag } ?? 0
        return IndexPath(row: index, section: 0)
    }
    
    func getAnnotationFor(indexPath: IndexPath, annotations: [MKAnnotation]) -> VehicleAnnotation? {
        let vehicle = self.vehicles[indexPath.row]
        return annotations.filter { vehicle.id == ($0 as! VehicleAnnotation).id}.first as? VehicleAnnotation
    }
}
