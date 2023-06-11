//
//  CoreLocationServiceKey.swift
//  FruitBowl
//
//  Created by timas on 2023-06-11.
//

import Foundation
import SwiftUI

struct CoreLocationServiceKey: EnvironmentKey {
  static let defaultValue = CoreLocationService()
}

extension EnvironmentValues {
    var coreLocationService: CoreLocationService {
        self[CoreLocationServiceKey.self]
    }
}
