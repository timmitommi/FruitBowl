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
    
public struct Departure: Codable {
    private static let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter
    }()
    
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
    
    public var departureDate: Date? {
        return Self.dateFormatter.date(from: "\(date) \(time)")
    }
    
    public var realDepartureDate: Date? {
        guard let realTime else {
            return nil
        }
        
        return Self.dateFormatter.date(from: "\(date) \(realTime)")
    }
}
