//
//  File.swift
//  
//
//  Created by timas on 2023-06-11.
//

import Foundation

struct NearbyStopsQuery: APIQuery {
    let path = "location.nearbystops"
    
    struct Parameters: APIQueryParameters {
        private let format = "json"
        let accessId: String
        let originCoordLat: String
        let originCoordLong: String
        let radius: String
        let maxNo: String
        
        init(accessId: String, coordinates: Coordinates, radius: Int, maxNo: Int) {
            self.accessId = accessId
            self.originCoordLat = String(coordinates.lat)
            self.originCoordLong = String(coordinates.lon)
            self.radius = String(radius)
            self.maxNo = String(maxNo)
        }
    }
    
    let parameters: Parameters
}
