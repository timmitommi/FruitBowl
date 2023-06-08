//
//  FruitBowlApp.swift
//  FruitBowl
//
//  Created by timas on 2023-06-07.
//

import SwiftUI

@main
struct FruitBowlApp: App {
    private let service = MuseumArtCollectionService()
    
    @State var fetchedArtObject: ArtObject?
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if let fetchedArtObject,
                   let image = fetchedArtObject.image {
                    image
                }
            }
            .task {
                do {
                    let result = try await service.getArtObject(withIds: 430)
                    
                    fetchedArtObject = result[0]
                } catch {
                    
                }
            }
        }
    }
}
