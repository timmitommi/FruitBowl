//
//  Endpoint.swift
//
//
//  Created by timas on 2023-06-07.
//

import Foundation

enum Endpoint {
    private static let baseURL = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/")!
    
    case allAvailableObjects(filteredByDepartmentIds: [Int])
    case allAvailableDepartments
    case artObject(id: Int)
    case search(with: SearchFilter)
    
    private var pathAndQueryItems: (path: String, queryItems: [URLQueryItem]?) {
        switch self {
        case .allAvailableObjects(let departmentIds):
            let queryItems: [URLQueryItem] = if departmentIds.count > 0 {
                [
                    URLQueryItem(name: "departmentIds", value: departmentIds.map(String.init).joined(separator: "|"))
                ]
            } else {
                []
            }
            
            return ("objects", queryItems)
        case .allAvailableDepartments:
            return ("departments", nil)
        case .artObject(let id):
            return ("objects/\(String(id))", nil)
        case .search(let searchFilter):
            return ("search", searchFilter.queryItems)
        }
    }
    
    var urlRequest: URLRequest {
        let (path, queryItems) = pathAndQueryItems
        let url = URL(string: path, relativeTo: Self.baseURL)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if let queryItems {
            components.queryItems = queryItems            
        }
        
        return URLRequest(url: components.url!)
    }
}
