//
//  Event.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/10/23.
//

import Foundation

/// The result of events returned by the call.
struct Event: Decodable, Hashable {
    
    let id: Int
    let thumbnail: Thumbnail
    
    enum CodingKeys: CodingKey {
        case id
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
    }
    
    // MARK: Hashable
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A wrapper for the data returned by the Marvel API when fetching a list of events.
struct EventDataWrapper: Decodable {
    let data: EventDataContainer
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(EventDataContainer.self, forKey: .data)
    }
}

/// The data returned by the call.
struct EventDataContainer: Decodable {
    let results: [Event]
    
    enum CodingKeys: CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Event].self, forKey: .results)
    }
}
