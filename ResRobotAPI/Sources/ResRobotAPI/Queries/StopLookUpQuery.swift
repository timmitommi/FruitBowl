//
//  File.swift
//  
//
//  Created by timas on 2023-06-09.
//

import Foundation

public enum StopLookUpQuerySearchMethod {
    case exactSearch
    case fuzzySearch
}

struct StopLookUpQuery: APIQuery {
    let path = "location.name"
    
    struct Parameters: APIQueryParameters {
        private let format = "json"
        let accessId: String
        let input: String
        let maxNo: String
        
        init(accessId: String, input: String, maxNo: Int, searchMethod: StopLookUpQuerySearchMethod) {
            self.accessId = accessId
            self.input = "\(input)\(searchMethod == .fuzzySearch ? "?" : "")"
            self.maxNo = String(maxNo)
        }
    }
    
    let parameters: Parameters
}
