//
//  File.swift
//  
//
//  Created by timas on 2023-06-07.
//

import Foundation

struct AvailableDepartments: Codable {
    let departments: [Department]
}

struct Department: Codable {
    let departmentId: Int
    let displayName: String
}

