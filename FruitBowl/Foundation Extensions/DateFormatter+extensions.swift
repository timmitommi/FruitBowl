//
//  DateFormatter+extension.swift
//  FruitBowl
//
//  Created by timas on 2023-06-10.
//

import Foundation

extension DateFormatter {
    static let resRobotDateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter
    }()
}
