//
//  VehicleViewModelTests.swift
//  RideTestTests
//
//  Created by Paritosh_raval on 22/07/21.
//

import XCTest
import MapKit
@testable import RideTest

class VehicleViewModelTests: XCTestCase {

    private let vehicleViewModel = VehicleViewModel()


    func testLocationArrayWithoutParse() {
        let array = vehicleViewModel.getLocationArray()
        XCTAssertEqual(array.count, 0)
    }
    
    func testLocationArrayWithParse() {
        vehicleViewModel.getVehicleData()
        let array = vehicleViewModel.getLocationArray()
        XCTAssertEqual(array.count, 3)
    }
    
    func testGetVehicle() {
        vehicleViewModel.getVehicleData()
        let vehicle = vehicleViewModel.getVehicle(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(vehicle.id, 84)
    }
    
    func testGetIndexPath() {
        vehicleViewModel.getVehicleData()
        let annotationView = MKAnnotationView()
        annotationView.tag = 1102
        let indexPath = vehicleViewModel.getIndexPathFor(annotationView: annotationView)
        XCTAssertEqual(indexPath.row, 1)
    }

}
