//
//  Departure.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import Foundation

struct Departure {
    let direction: String
    let stopName: String
    let stopId: String
    let time: String
    let realTime: String?
    let date: String
    
    var departureDate: Date? {
        return DateFormatter.resRobotDateFormatter.date(from: "\(date) \(time)")
    }
    
    var realDepartureDate: Date? {
        guard let realTime else {
            return nil
        }
        
        return DateFormatter.resRobotDateFormatter.date(from: "\(date) \(realTime)")
    }
}
