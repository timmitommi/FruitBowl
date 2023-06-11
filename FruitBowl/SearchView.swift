//
//  SearchView.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import SwiftUI

struct SearchViewContainer: View {
    @Environment(\.resRobotAPIService) private var resRobotAPIService
    
    var body: some View {
        SearchView {
            return try await resRobotAPIService.searchForStation(withName: $0)
        }
        .task {
            do {
                let result = try await resRobotAPIService.getNearbyStations(forCoordinates: Coordinates(lat: 59.330136, lon: 18.158151))
                
                print(result[0].name)
            } catch {
                print(error)
            }
        }
    }
}

struct SearchView: View {
    enum SearchState {
        case loading
        case result([Station])
        case error(Error)
    }
    
    let searchAction: @MainActor (String) async throws -> [Station]

    @State private var searchText = ""
    @State private var searchResult: SearchState?
    
    @FocusState private var searchTextFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            TextField("Search for a station", text: $searchText)
                .focused($searchTextFieldIsFocused)
                .onSubmit {
                    Task {
                        do {
                            let stations = try await searchAction(searchText)
                            
                            searchResult = .result(stations)
                        } catch {
                            searchResult = .error(error)
                        }
                    }
                }
            
            List {
                if let searchResult {
                    switch searchResult {
                    case .loading:
                        Text("Loading")
                    case .result(let stations):
                        ForEach(stations) { station in
                            Text(station.name)
                        }
                    case .error(let error):
                        Text(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView { _ in
        return [Station(id: "test", name: "test", lon: 1, lat: 1, weight: 1, products: 1, distance: 1)]
    }
}
