//
//  VehicleParserTests.swift
//  RideTestTests
//
//  Created by Paritosh_raval on 22/07/21.
//

import XCTest
@testable import RideTest

class VehicleParserTests: XCTestCase {

    func testParseJsonForInValidFile() {
        let parser = VehicleParser()
        let vehicleArray = parser.parseJson(fileName: "test")
        XCTAssertNil(vehicleArray)
    }
    
    func testParseJsonForValidFile() {
        let parser = VehicleParser()
        let vehicleArray = parser.parseJson(fileName: "Vehicles")
        XCTAssertEqual(vehicleArray?.count, 3)

    }

}
