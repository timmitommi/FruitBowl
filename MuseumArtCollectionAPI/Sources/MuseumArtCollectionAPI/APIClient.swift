//
//  MusuemArtCollectionAPIClient.swift
//  
//
//  Created by timas on 2023-06-07.
//

import Foundation

public typealias ArtObjectImage = Data

public protocol APIClientProtocol {
    func getAvailableArtObjects(filteredByDepartmentsIds ids: Int...) async throws -> AvailableArtObjects
    func getAvailableArtObjects(filteredBySearch filter: SearchFilter) async throws -> AvailableArtObjects
    func getAvailableDepartments() async throws -> AvailableDepartments
    func getArtObject(withId id: Int) async throws -> (ArtObject, ArtObjectImage?)
}

public struct APIClient: APIClientProtocol {
    private let cache = ArtObjectCache()
    
    public init() {}
    
    public func getAvailableArtObjects(filteredByDepartmentsIds ids: Int...) async throws -> AvailableArtObjects {
        return try await getRequest(toEndpoint: .allAvailableObjects(filteredByDepartmentIds: ids))
    }
    
    public func getAvailableArtObjects(filteredBySearch filter: SearchFilter) async throws -> AvailableArtObjects {
        return try await getRequest(toEndpoint: .search(with: filter))
    }
    
    public func getAvailableDepartments() async throws -> AvailableDepartments {
        return try await getRequest(toEndpoint: .allAvailableDepartments)
    }
    
    public func getArtObject(withId id: Int) async throws -> (ArtObject, ArtObjectImage?) {
        let artObject: ArtObject = try await getRequest(toEndpoint: .artObject(id: id))
        
        guard let primarySmallImageUrl = URL(string: artObject.primaryImageSmall) else {
            return (artObject, nil)
        }
        
        let data = try await getData(forUrlRequest: URLRequest(url: primarySmallImageUrl))
        
        return (artObject, data)
    }
    
    private func getRequest<T: Decodable>(toEndpoint endpoint: Endpoint) async throws -> T {
        let urlRequest = endpoint.urlRequest
        
        let data = try await getData(forUrlRequest: urlRequest)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func getData(forUrlRequest urlRequest: URLRequest) async throws -> Data {
        if let cachedData = try cache.getData(forUrlRequest: urlRequest) {
            return cachedData
        } else {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            cache.saveData(urlRequest: urlRequest, urlResponse: response, data: data)
            
            return data
        }
    }
}
