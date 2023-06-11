//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//

import Foundation

public final class ResRobotAPIClient {
    private static let baseURL = URL(string: "https://api.resrobot.se/v2.1/")!
    
    private let apiKey: String
    private let urlRequestBuilder: URLRequestBuilder
    
    public init(apiKey: String) {
        self.apiKey = apiKey
        self.urlRequestBuilder = .init(baseURL: Self.baseURL)
    }
    
    public func searchForStation(withName name: String, maxNumberOfResults: Int, searchMethod: StopLookUpQuerySearchMethod) async throws -> [Station] {
        let query = StopLookUpQuery(parameters: .init(accessId: apiKey, input: name, maxNo: maxNumberOfResults, searchMethod: searchMethod))
        
        let response: StationRootResponse = try await getRequest(forQuery: query)
        
        return response.stopLocationOrCoordLocation.compactMap(\.stopLocation)
    }
    
    public func getNearbyStations(forCoordinates coordinates: Coordinates, maxNumberOfResults: Int, radius: Int) async throws -> [Station]{
        let query = NearbyStopsQuery(parameters: .init(accessId: apiKey, coordinates: coordinates, radius: radius, maxNo: maxNumberOfResults))
        
        let response: StationRootResponse = try await getRequest(forQuery: query)
        
        return response.stopLocationOrCoordLocation.compactMap(\.stopLocation)
    }
    
    public func getDeparturesForStation(withId id: String, duration: Int) async throws -> [Departure] {
        let query = TimetableQuery(queryMethod: .departures, parameters: .init(accessId: apiKey, id: id, duration: duration))
        
        let response: DeparturesRootResponse = try await getRequest(forQuery: query)
        
        return response.departure
    }
    
    private func getRequest<Query: APIQuery, T: Decodable>(forQuery query: Query) async throws -> T {
        let request = urlRequestBuilder.buildURLRequest(forQuery: query)
        return try await getData(forUrlRequest: request)
    }
    
    private func getData<T: Decodable>(forUrlRequest urlRequest: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        prettyPrint(data: data)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func prettyPrint(data: Data) {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                     options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            print(prettyJSON)
        }
    }
}
