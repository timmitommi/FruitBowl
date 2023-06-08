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
        
        let (data, _) = try await URLSession.shared.data(from: primarySmallImageUrl)
        
        return (artObject, data)
    }
    
    private func getArtObjectImage(withImageUrl url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
    
    private func getRequest<T: Decodable>(toEndpoint endpoint: Endpoint) async throws -> T {
        let urlRequest = endpoint.urlRequest
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
