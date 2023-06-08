//
//  ArtObject.swift
//  
//
//  Created by timas on 2023-06-07.
//

import Foundation

public struct ArtObject: Codable {
    public let objectID: Int
    public let isHighlight: Bool
    public let accessionNumber: String
    public let accessionYear: String
    public let isPublicDomain: Bool
    public let primaryImage: String
    public let primaryImageSmall: String
    public let additionalImages: [String]
    public let constituents: [Constituent]
    public let department: String
    public let objectName: String
    public let title: String
    public let culture: String
    public let period: String
    public let dynasty: String
    public let reign: String
    public let portfolio: String
    public let artistRole: String
    public let artistPrefix: String
    public let artistDisplayName: String
    public let artistDisplayBio: String
    public let artistSuffix: String
    public let artistAlphaSort: String
    public let artistNationality: String
    public let artistBeginDate: String
    public let artistEndDate: String
    public let artistGender: String
    public let artistWikidata_URL: String
    public let artistULAN_URL: String
    public let objectDate: String
    public let objectBeginDate: Int
    public let objectEndDate: Int
    public let medium: String
    public let dimensions: String
    public let measurements: [Measurement]
    public let creditLine: String
    public let geographyType: String
    public let city: String
    public let state: String
    public let county: String
    public let country: String
    public let region: String
    public let subregion: String
    public let locale: String
    public let locus: String
    public let excavation: String
    public let river: String
    public let classification: String
    public let rightsAndReproduction: String
    public let linkResource: String
    public let metadataDate: String
    public let repository: String
    public let objectURL: String
    public let tags: [Tag]?
    public let objectWikidata_URL: String
    public let isTimelineWork: Bool
}

public struct Constituent: Codable {
    public let constituentID: Int
    public let role: String
    public let name: String
    public let constituentULAN_URL: String
    public let constituentWikidata_URL: String
    public let gender: String
}

public struct Measurement: Codable {
    public let elementName: String
    public let elementDescription: String?
    public let elementMeasurements: ElementMeasurements
}

public struct ElementMeasurements: Codable {
    public let height: Double?
    public let width: Double?
    public let depth: Double?
    
    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case width = "Width"
        case depth = "Depth"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.height = try container.decodeIfPresent(Double.self, forKey: .height)
        self.width = try container.decodeIfPresent(Double.self, forKey: .width)
        self.depth = try container.decodeIfPresent(Double.self, forKey: .depth)
    }
}

public struct Tag: Codable {
    public let term: String
    public let AAT_URL: String
    public let Wikidata_URL: String
}

