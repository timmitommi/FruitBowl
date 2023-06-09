//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//

import Foundation

final class URLRequestBuilder {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func buildURLRequest<Query: APIQuery>(forQuery query: Query) -> URLRequest {
        let url = URL(string: query.path, relativeTo: baseURL)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if let queryItems = query.queryItems {
            components.queryItems = queryItems
        }
        
        return URLRequest(url: components.url!)
    }
}
