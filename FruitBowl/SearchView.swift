//
//  SearchView.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import SwiftUI

struct SearchViewContainer: View {
    @Environment(\.resRobotAPIService) private var resRobotAPIService
    @Environment(\.coreLocationService) private var coreLocationService
    @State private var closeStations: [Station]?
    
    var body: some View {
        SearchView(closeStations: closeStations) {
            return try await resRobotAPIService.searchForStation(withName: $0)
        }
        .onReceive(coreLocationService.$latestUserCoordinates) { coordinates in
            guard let coordinates else {
                return
            }
            
            Task {
                do {
                    closeStations = try await resRobotAPIService.getNearbyStations(forCoordinates: coordinates)
                } catch {
                    print(error)
                }
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
    
    var closeStations: [Station]?
    let searchAction: @MainActor (String) async throws -> [Station]

    @State private var searchText = ""
    @State private var searchResult: SearchState?
    
    @FocusState private var searchTextFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            TextField("Search for a station", text: $searchText)
                .focused($searchTextFieldIsFocused)
                .onSubmit {
                    searchResult = .loading
                    
                    Task {
                        do {
                            let stations = try await searchAction(searchText)
                            
                            searchResult = .result(stations)
                        } catch {
                            searchResult = .error(error)
                        }
                    }
                }
            
            if let closeStations {
                VStack {
                    Text("Close stations")
                    
                    ForEach(closeStations) {
                        Text($0.name)
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

struct SearchViewPreview: PreviewProvider {
    static var previews: some View {
        SearchView { _ in
            return [Station(id: "test", name: "test", lon: 1, lat: 1, weight: 1, products: 1, distance: 1)]
        }
    }
}
