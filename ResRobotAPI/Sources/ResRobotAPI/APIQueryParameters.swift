//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//

import Foundation

protocol APIQueryParameters {
    var queryItems: [URLQueryItem]? { get }
}

extension APIQueryParameters {
    var queryItems: [URLQueryItem]? {
        let mirror = Mirror(reflecting: self)
        
        return mirror.children.reduce(into: [URLQueryItem]()) { result, next in
            if let label = next.label, let value = next.value as? String {
                let queryItem = URLQueryItem(name: label, value: value)
                result.append(queryItem)
            }
        }
    }
}
