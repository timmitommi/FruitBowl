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
    
    var body: some View {
        SearchViewContainer()
            .environment(\.resRobotAPIService, resRobotAPIService)
    }
}

#Preview {
    ContentView()
}
