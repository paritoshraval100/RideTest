//
//  VehicleParser.swift
//  RideTest
//
//  Created by Paritosh_raval on 22/07/21.
//

import Foundation


struct VehicleParser {
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func parseJson(fileName: String) -> [Vehicle]? {
        let data = readLocalFile(forName: fileName)
        if let jsonData = data {
            do {
                return try JSONDecoder().decode(Array<Vehicle>.self, from: jsonData)
            } catch {
                print("decode error", error)
            }
        }
        return nil
    }
}
