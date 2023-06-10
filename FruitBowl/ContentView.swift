//
//  ContentView.swift
//  FruitBowl
//
//  Created by timas on 2023-06-07.
//

import SwiftUI
import ResRobotAPI

fileprivate let apiKey = ProcessInfo.processInfo.environment["API_KEY"]!

struct ContentView: View {
    private let resRobotAPIClient = ResRobotAPIClient(apiKey: apiKey)
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let sundbyberg = try await resRobotAPIClient.searchForStation(withName: "Sundbyberg Centrum", maxNumberOfResults: 1, searchMethod: .exactSearch).first
                
                guard let sundbyberg else {
                    return
                }
                
                print(sundbyberg)
                
                let result = try await resRobotAPIClient.getDeparturesForStation(withId: sundbyberg.id, duration: 20)
                
                print(result)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
