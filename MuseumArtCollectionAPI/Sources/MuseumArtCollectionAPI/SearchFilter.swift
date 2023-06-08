//
//  File.swift
//  
//
//  Created by timas on 2023-06-08.
//

import Foundation

public struct SearchFilter {
    public let q: String
    public let isHighlighted: Bool?
    public let title: Bool?
    public let tags: Bool?
    public let departmentId: Int?
    public let isOnView: Bool?
    public let artistOrCulture: Bool?
    public let medium: [String]?
    public let hasImages: Bool?
    public let geoLocation: [String]?
    
    ///Encodes begining and end in years. -100 means B.C and 100 means 100 A.D.
    public let dateBeginAndEnd: (Int, Int)?
    
    public init(q: String, isHighlighted: Bool? = nil, title: Bool? = nil, tags: Bool? = nil, departmentId: Int? = nil, isOnView: Bool? = nil, artistOrCulture: Bool? = nil, medium: [String]? = nil, hasImages: Bool? = nil, geoLocation: [String]? = nil, dateBeginAndEnd: (Int, Int)? = nil) {
        self.q = q
        self.isHighlighted = isHighlighted
        self.title = title
        self.tags = tags
        self.departmentId = departmentId
        self.isOnView = isOnView
        self.artistOrCulture = artistOrCulture
        self.medium = medium
        self.hasImages = hasImages
        self.geoLocation = geoLocation
        self.dateBeginAndEnd = dateBeginAndEnd
    }
    
    var queryItems: [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        
        return mirror.children.reduce(into: [URLQueryItem]()) { result, next in
            if let label = next.label, let value = next.value as? String {
                result.append(URLQueryItem(name: label, value: value))
            }
        }
    }
}
