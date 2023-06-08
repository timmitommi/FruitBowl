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
        return try await withThrowingTaskGroup(of: (MuseumArtCollectionAPI.ArtObject, Data?).self, returning: [ArtObject].self) { taskGroup in
            for id in ids {
                taskGroup.addTask { try await apiClient.getArtObject(withId: id) }
            }
    
            var artObjects = [ArtObject]()
            for try await (artObject, data) in taskGroup {
                artObjects.append(ArtObject(id: artObject.objectID, name: artObject.objectName, imageData: data))
            }
                                  
            return artObjects
        }
    }
    
    func getAvailableDepartments() async throws -> [Department] {
        return try await apiClient
            .getAvailableDepartments()
            .departments
            .map { Department(id: $0.departmentId, name: $0.displayName) }
    }
}
