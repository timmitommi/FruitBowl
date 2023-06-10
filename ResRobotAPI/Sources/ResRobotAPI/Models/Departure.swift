//
//  File.swift
//  
//
//  Created by timas on 2023-06-10.
//

import Foundation

struct DeparturesRootResponse: Codable {
    let departure: [Departure]
    
    private enum CodingKeys: String, CodingKey {
        case departure = "Departure"
    }
}
    
public struct Departure: Codable, Hashable {
    public let direction: String
    public let stopName: String
    public let stopId: String
    public let time: String
    public let realTime: String?
    public let date: String
    
    private enum CodingKeys: String, CodingKey {
        case direction
        case stopName = "stop"
        case stopId = "stopid"
        case time
        case realTime = "rtTime"
        case date
    }
    
    enum Error: Swift.Error {
        case couldNotDecodeTime
    }
        
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.direction = try container.decode(String.self, forKey: .direction)
        self.stopName = try container.decode(String.self, forKey: .stopName)
        self.stopId = try container.decode(String.self, forKey: .stopId)
        self.date = try container.decode(String.self, forKey: .date)
        self.time = try container.decode(String.self, forKey: .time)
        self.realTime = try container.decodeIfPresent(String.self, forKey: .realTime)
    }
}
