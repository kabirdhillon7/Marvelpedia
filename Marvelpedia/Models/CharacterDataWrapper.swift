//
//  CharacterDataWrapper.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/6/23.
//

import Foundation

// MARK: CharacterDataWrapper
struct CharacterDataWrapper: Decodable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: CharacterDataContainer
    let etag: String
    
    enum CodingKeys: CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case data
        case etag
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.status = try container.decode(String.self, forKey: .status)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.attributionText = try container.decode(String.self, forKey: .attributionText)
        self.attributionHTML = try container.decode(String.self, forKey: .attributionHTML)
        self.data = try container.decode(CharacterDataContainer.self, forKey: .data)
        self.etag = try container.decode(String.self, forKey: .etag)
    }
}

/// The results returned by the call
struct CharacterDataContainer: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
    
    enum CodingKeys: CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.total = try container.decode(Int.self, forKey: .total)
        self.count = try container.decode(Int.self, forKey: .count)
        self.results = try container.decode([Character].self, forKey: .results)
    }
}
