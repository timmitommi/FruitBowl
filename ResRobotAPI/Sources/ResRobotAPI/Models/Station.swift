//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//

import Foundation

struct StationRootResponse: Codable {
    let stopLocationOrCoordLocation: [StationResponse]
}
    
struct StationResponse: Codable {
    let stopLocation: Station?
    
    private enum CodingKeys: String, CodingKey {
        case stopLocation = "StopLocation"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stopLocation = try container.decodeIfPresent(Station.self, forKey: .stopLocation)
    }
}

public struct Station: Codable {
    public let id: String
    public let name: String
    public let lon: Double
    public let lat: Double
    public let weight: Int
    public let products: Int
    public let distance: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "extId"
        case name
        case lon
        case lat
        case weight
        case products
        case distance = "dist"
    }
}
