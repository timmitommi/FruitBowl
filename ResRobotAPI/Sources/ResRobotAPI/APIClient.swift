//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//

import Foundation

public final class APIClient {
    private static let baseURL = URL(string: "https://api.resrobot.se/v2.1/")!
    
    private let apiKey: String
    private let urlRequestBuilder: URLRequestBuilder
    
    public init(apiKey: String) {
        self.apiKey = apiKey
        self.urlRequestBuilder = .init(baseURL: Self.baseURL)
    }
    
    public func searchForStation(withName name: String, maxNumberOfResults: Int, searchMethod: SearchMethod) async throws -> [Station] {
        let query = StopLookUpQuery(parameters: .init(accessId: apiKey, input: name, maxNo: maxNumberOfResults, searchMethod: searchMethod))
        
        let request = urlRequestBuilder.buildURLRequest(forQuery: query)
        let response: StationRootResponse = try await getData(forUrlRequest: request)
        
        return response.stopLocationOrCoordLocation.compactMap(\.stopLocation)
    }
    
    private func getData<T: Decodable>(forUrlRequest urlRequest: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
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
