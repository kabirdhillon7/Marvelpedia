//
//  CharacterDataWrapper.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/6/23.
//

import Foundation

// MARK: CharacterDataWrapper
struct CharacterDataWrapper: Decodable {
    let code: Int?
    let status: String?
    let copyright: String
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterDataContainer?
    let etag: String?
}

/// The results returned by the call
struct CharacterDataContainer: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
}
