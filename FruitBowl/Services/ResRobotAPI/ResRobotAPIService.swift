//
//  ResRobotAPIService.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import Foundation
import ResRobotAPI

fileprivate let apiKey = ProcessInfo.processInfo.environment["API_KEY"]!

protocol ResRobotAPIServiceProtocol {
    func searchForStation(withName name: String, numberOfResults: Int) async throws -> [Station]
    func getNearbyStations(forCoordinates coordinates: Coordinates, radius: Int, numberOfResults: Int) async throws -> [Station]
    func getDepartures(fromStationWithId id: String, minutesFromNow: Int) async throws -> [Departure]
}

final class ResRobotAPIService: ResRobotAPIServiceProtocol {
    private let apiClient = ResRobotAPIClient(apiKey: apiKey)
    
    func searchForStation(withName name: String, numberOfResults: Int = 5) async throws -> [Station] {
        let stations = try await apiClient.searchForStation(withName: name, maxNumberOfResults: numberOfResults, searchMethod: .fuzzySearch)
        
        return stations.map { Station(from: $0) }
    }
    
    func getDepartures(fromStationWithId id: String, minutesFromNow: Int = 60) async throws -> [Departure] {
        let departures = try await apiClient.getDeparturesForStation(withId: id, duration: minutesFromNow)
        
        return departures.map { Departure(from: $0) }
    }
    
    func getNearbyStations(forCoordinates coordinates: Coordinates, radius: Int = 1000, numberOfResults: Int = 5) async throws -> [Station] {
        let stations = try await apiClient.getNearbyStations(forCoordinates: ResRobotAPI.Coordinates(lat: coordinates.lat, lon: coordinates.lon), maxNumberOfResults: numberOfResults, radius: radius)

        return stations.map { Station(from: $0) }
    }
}

private extension Station {
    init(from apiStation: ResRobotAPI.Station) {
        self.id = apiStation.id
        self.name = apiStation.name
        self.products = apiStation.products
        self.weight = apiStation.weight
        self.lat = apiStation.lat
        self.lon = apiStation.lon
        self.distance = apiStation.distance
    }
}

private extension Departure {
    init(from apiDeparture: ResRobotAPI.Departure) {
        self.date = apiDeparture.date
        self.time = apiDeparture.time
        self.direction = apiDeparture.direction
        self.realTime = apiDeparture.realTime
        self.stopId = apiDeparture.stopId
        self.stopName = apiDeparture.stopName
    }
}
