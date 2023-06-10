//
//  ContentView.swift
//  FruitBowl
//
//  Created by timas on 2023-06-07.
//

import SwiftUI
import ResRobotAPI

struct ContentView: View {
    private let resRobotAPIService = ResRobotAPIService()
    
    @State var results: [Station]?
    
    var body: some View {
        Group {
            if let results {
                List {
                    ForEach(results) { station in
                        Text(station.name)
                    }
                }
            }
        }
        .task {
            do {
                results = try await resRobotAPIService.searchForStation(withName: "Sundbyberg")
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
