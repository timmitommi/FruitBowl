//
//  EnvironmentValues+ResRobotAPIServiceKey.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import Foundation
import SwiftUI

struct ResRobotAPIServiceKey: EnvironmentKey {
  static let defaultValue = ResRobotAPIService()
}

extension EnvironmentValues {
    var resRobotAPIService: ResRobotAPIService {
        self[ResRobotAPIServiceKey.self]
    }
}
