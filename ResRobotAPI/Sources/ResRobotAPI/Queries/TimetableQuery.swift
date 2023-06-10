//
//  File.swift
//  
//
//  Created by timas on 2023-06-10.
//

import Foundation

public enum TimetableQueryMethod {
    case arrivals
    case departures
}

struct TimetableQuery: APIQuery {
    var path: String {
        switch queryMethod {
        case .arrivals:
            "arrivalBoard"
        case .departures:
            "departureBoard"
        }
    }
    
    struct Parameters: APIQueryParameters {
        private let format = "json"
        let accessId: String
        let id: String
        let duration: String
        
        init(accessId: String, id: String, duration: Int) {
            self.accessId = accessId
            self.id = id
            self.duration = String(duration)
        }
    }
    
    let queryMethod: TimetableQueryMethod
    let parameters: Parameters
}
