//
//  Station.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import Foundation

struct Station: Identifiable {
    let id: String
    let name: String
    let lon: Double
    let lat: Double
    let weight: Int
    let products: Int
}
