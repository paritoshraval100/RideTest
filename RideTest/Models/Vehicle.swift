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
    let latitude: Double?
    let longitude: Double?
    let vehicleMake: String
    let vehicleMilage: Int
    let imageURL: String
    
    var title: String {
        "\(id) \(vehicleMake)"
    }
    
    var milage: String {
        "\(vehicleMilage)g"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, pool, latitude="lat", longitude="lng", vehicleMake = "vehicle_make", vehicleMilage = "remaining_mileage", imageURL = "vehicle_pic_absolute_url"
    }
}
