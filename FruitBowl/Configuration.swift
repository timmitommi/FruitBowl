//
//  Environment.swift
//  FruitBowl
//
//  Created by timas on 2023-06-11.
//

import Foundation

enum Configuration {
    enum ConfigKey: String {
        case resRobotApiKey = "RESROBOT_API_KEY"
    }
    
    private static var infoPlist: [String: Any] {
        guard let infoPlist = Bundle.main.infoDictionary else {
            fatalError("no plist file was found")
        }
        
        return infoPlist
    }
    
    private static func infoPlistValue(forKey key: ConfigKey) -> Any? {
        return infoPlist[key.rawValue]
    }
    
    static var resRobotApiKey: String {
        guard let apiKey = infoPlistValue(forKey: .resRobotApiKey) as? String else {
            fatalError("no api key was found")
        }

        return apiKey
    }
}
