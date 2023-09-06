//
//  Character.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import Foundation

/// The list of characters returned by the call
struct Character: Decodable {
    let id: Int?
    let description: String?
    let modified: Date?
    let resourceURI: String?
    let urls: [URL]?
    let thumnail: Thumbnail?
    let comics: ComicList?
    let stories: StoryList?
    let events: EventList?
    let series: SeriesList?
}

/// The representative image for a character
struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
}

/// A resource list containing comics which feature a character
struct ComicList: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
}

/// The list of returned issues in this collection
struct ComicSummary: Decodable {
    let resourceURI: String?
    let name: String?
}

/// A resource list of events in which a character appears
struct EventList: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
}

/// The list of returned events in this collection
struct EventSummary: Decodable {
    let resourceURI: String?
    let name: String?
}

/// A resource list of series in which a character appears
struct SeriesList: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
}

/// The list of returned series in this collection
struct SeriesSummary: Decodable {
    let resourceURI: String?
    let name: String?
}

/// A resource list of stories in which a character appears
struct StoryList: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StorySummary]?
}

/// The list of returned stories in this collection
struct StorySummary: Decodable {
    let resourceURI: String?
    let name: String?
    let type: String?
}
