//
//  Vehicle.swift
//  RideTest
//
//  Created by Paritosh_raval on 21/07/21.
//

import Foundation

struct Vehicle: Decodable {
    let id: Int
    let pool: String
    let lat: Double?
    let lng: Double?
    let vehicle_pic_absolute_url: String
    let vehicle_make: String
    let remaining_mileage: Int
    
    var title: String {
        "\(id) \(vehicle_make)"
    }
    
    var milage: String {
        "\(remaining_mileage)g"
    }
}
