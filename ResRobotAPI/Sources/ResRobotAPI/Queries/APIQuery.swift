//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//
import Foundation

protocol APIQuery {
    associatedtype Parameters: APIQueryParameters
    
    var queryItems: [URLQueryItem]? { get }
    var path: String { get }
    var parameters: Parameters { get }
}

extension APIQuery {
    var queryItems: [URLQueryItem]? {
        self.parameters.queryItems
    }
}
