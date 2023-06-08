//
//  ArtObject.swift
//  
//
//  Created by timas on 2023-06-07.
//

import Foundation

struct ArtObject: Codable {
    let objectID: Int
    let isHighlight: Bool
    let accessionNumber: String
    let accessionYear: String
    let isPublicDomain: Bool
    let primaryImage: String
    let primaryImageSmall: String
    let additionalImages: [String]
    let constituents: [Constituent]
    let department: String
    let objectName: String
    let title: String
    let culture: String
    let period: String
    let dynasty: String
    let reign: String
    let portfolio: String
    let artistRole: String
    let artistPrefix: String
    let artistDisplayName: String
    let artistDisplayBio: String
    let artistSuffix: String
    let artistAlphaSort: String
    let artistNationality: String
    let artistBeginDate: String
    let artistEndDate: String
    let artistGender: String
    let artistWikidata_URL: String
    let artistULAN_URL: String
    let objectDate: String
    let objectBeginDate: Int
    let objectEndDate: Int
    let medium: String
    let dimensions: String
    let measurements: [Measurement]
    let creditLine: String
    let geographyType: String
    let city: String
    let state: String
    let county: String
    let country: String
    let region: String
    let subregion: String
    let locale: String
    let locus: String
    let excavation: String
    let river: String
    let classification: String
    let rightsAndReproduction: String
    let linkResource: String
    let metadataDate: String
    let repository: String
    let objectURL: String
    let tags: [Tag]
    let objectWikidata_URL: String
    let isTimelineWork: Bool
}

struct Constituent: Codable {
    let constituentID: Int
    let role: String
    let name: String
    let constituentULAN_URL: String
    let constituentWikidata_URL: String
    let gender: String
}

struct Measurement: Codable {
    let elementName: String
    let elementDescription: String?
    let elementMeasurements: ElementMeasurements
}

struct ElementMeasurements: Codable {
    let height: Double
    let width: Double
    let depth: Double?
    
    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case width = "Width"
        case depth = "Depth"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.height = try container.decode(Double.self, forKey: .height)
        self.width = try container.decode(Double.self, forKey: .width)
        self.depth = try container.decodeIfPresent(Double.self, forKey: .depth)
    }
}

struct Tag: Codable {
    let term: String
    let AAT_URL: String
    let Wikidata_URL: String
}

