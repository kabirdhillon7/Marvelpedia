//
//  Character.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import Foundation

/// The list of characters returned by the call
struct Character: Decodable, Hashable {
    
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let resourceURI: String
    let urls: [Url]
    let thumbnail: Thumbnail
    let comics: ComicList
    let stories: StoryList
    let events: EventList
    let series: SeriesList
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case resourceURI
        case urls
        case thumbnail
        case comics
        case stories
        case events
        case series
    }
    
    // MARK: Init Using Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        
        let modifiedString = try container.decode(String.self, forKey: .modified)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DDTHH:mm:ssZ"
        self.modified = dateFormatter.date(from: modifiedString) ?? Date()
        
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
        self.urls = try container.decode([Url].self, forKey: .urls)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        self.comics = try container.decode(ComicList.self, forKey: .comics)
        self.stories = try container.decode(StoryList.self, forKey: .stories)
        self.events = try container.decode(EventList.self, forKey: .events)
        self.series = try container.decode(SeriesList.self, forKey: .series)
    }
    
    // MARK: Hashable
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A resource list containing comics which feature a character
struct ComicList: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [ComicSummary]
    
    enum CodingKeys: CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Int.self, forKey: .available)
        self.returned = try container.decode(Int.self, forKey: .returned)
        self.collectionURI = try container.decode(String.self, forKey: .collectionURI)
        self.items = try container.decode([ComicSummary].self, forKey: .items)
    }
}

/// The list of returned issues in this collection
struct ComicSummary: Decodable {
    let resourceURI: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case resourceURI
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

/// A resource list of events in which a character appears
struct EventList: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [EventSummary]
    
    enum CodingKeys: CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Int.self, forKey: .available)
        self.returned = try container.decode(Int.self, forKey: .returned)
        self.collectionURI = try container.decode(String.self, forKey: .collectionURI)
        self.items = try container.decode([EventSummary].self, forKey: .items)
    }
}

/// The list of returned events in this collection
struct EventSummary: Decodable {
    let resourceURI: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case resourceURI
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

/// The representative image for a character
struct Thumbnail: Decodable {
    let path: String
    let fileExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.fileExtension = try container.decode(String.self, forKey: .fileExtension)
    }
}

/// A resource list of series in which a character appears
struct SeriesList: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [SeriesSummary]
    
    enum CodingKeys: CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Int.self, forKey: .available)
        self.returned = try container.decode(Int.self, forKey: .returned)
        self.collectionURI = try container.decode(String.self, forKey: .collectionURI)
        self.items = try container.decode([SeriesSummary].self, forKey: .items)
    }
}

/// The list of returned series in this collection
struct SeriesSummary: Decodable {
    let resourceURI: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case resourceURI
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

/// A resource list of stories in which a character appears
struct StoryList: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [StorySummary]
    
    enum CodingKeys: CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Int.self, forKey: .available)
        self.returned = try container.decode(Int.self, forKey: .returned)
        self.collectionURI = try container.decode(String.self, forKey: .collectionURI)
        self.items = try container.decode([StorySummary].self, forKey: .items)
    }
}

/// The list of returned stories in this collection
struct StorySummary: Decodable {
    let resourceURI: String
    let name: String
    let type: String
    
    enum CodingKeys: CodingKey {
        case resourceURI
        case name
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
    }
}

/// A set of public web site URLs for the resource
struct Url: Decodable {
    let type: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case type
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
