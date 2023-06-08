//
//  File.swift
//  
//
//  Created by timas on 2023-06-07.
//

import Foundation

public struct AvailableDepartments: Codable {
    public let departments: [Department]
}

public struct Department: Codable {
    public let departmentId: Int
    public let displayName: String
}

