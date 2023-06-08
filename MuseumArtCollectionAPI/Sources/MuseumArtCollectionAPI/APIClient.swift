//
//  MusuemArtCollectionAPIClient.swift
//  
//
//  Created by timas on 2023-06-07.
//

import Foundation

protocol APIClientProtocol {
    func getAvailableArtObjects(filteredByDepartmentsIds ids: Int...) async throws -> AvailableArtObjects
    func getAvailableDepartments() async throws -> AvailableDepartments
    func getArtObject(withId id: Int) async throws -> ArtObject
}

struct APIClient: APIClientProtocol {
    func getAvailableArtObjects(filteredByDepartmentsIds ids: Int...) async throws -> AvailableArtObjects {
        return try await getRequest(toEndpoint: .allAvailableObjects(filteredByDepartmentIds: ids))
    }
    
    func getAvailableDepartments() async throws -> AvailableDepartments {
        return try await getRequest(toEndpoint: .allAvailableDepartments)
    }
    
    func getArtObject(withId id: Int) async throws -> ArtObject {
        return try await getRequest(toEndpoint: .artObject(id: id))
    }
    
    private func getRequest<T: Decodable>(toEndpoint endpoint: Endpoint) async throws -> T {
        let urlRequest = endpoint.urlRequest
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
