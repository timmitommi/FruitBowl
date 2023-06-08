//
//  MuseumArtCollectionService.swift
//  FruitBowl
//
//  Created by timas on 2023-06-08.
//

import Foundation
import MuseumArtCollectionAPI

protocol MuseumArtCollectionServiceProtocol {
    func getArtObject(withIds ids: Int...) async throws -> [ArtObject]
    func getAvailableDepartments() async throws -> [Department]
}

struct MuseumArtCollectionService: MuseumArtCollectionServiceProtocol {
    private let apiClient = APIClient()
    
    func getArtObject(withIds ids: Int...) async throws -> [ArtObject] {
        let (object, imageData) = try await apiClient
            .getArtObject(withId: ids[0])
        
        return [ArtObject(id: object.objectID,
                          name: object.objectName,
                          imageData: imageData)]
    }
    
    func getAvailableDepartments() async throws -> [Department] {
        return try await apiClient
            .getAvailableDepartments()
            .departments
            .map { Department(id: $0.departmentId, name: $0.displayName) }
    }
}
