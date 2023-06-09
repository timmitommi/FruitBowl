//
//  File.swift
//  
//
//  Created by timas on 2023-06-08.
//

import Foundation

struct ArtObjectCache {
    let cache = URLCache.shared
    
    func getData(forUrlRequest urlRequest: URLRequest) -> Data? {
        cache.cachedResponse(for: urlRequest)?.data
    }
    
    func saveData(urlRequest: URLRequest, urlResponse: URLResponse, data: Data) {
        let cachedData = CachedURLResponse(response: urlResponse, data: data)
        cache.storeCachedResponse(cachedData, for: urlRequest)
    }
}
