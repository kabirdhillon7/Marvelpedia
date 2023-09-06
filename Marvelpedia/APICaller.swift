//
//  APICaller.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import Foundation
import Combine
import CryptoKit

struct APICaller {
    
    // MARK: API Keys
    let publicKey = Bundle.main.infoDictionary?["PUBLIC_API_KEY"] as? String ?? ""
    let privateKey = Bundle.main.infoDictionary?["PRIVATE_API_KEY"] as? String ?? ""
    
    // MARK: Timestamp
    var timestamp: String {
        return "\(Date().timeIntervalSince1970)"
    }
    
    // MARK: MD5 Hash
    var md5Hash: String {
        let input = timestamp + publicKey + privateKey
        guard let data = input.data(using: .utf8) else {
            return ""
        }
        let hash = SHA512.hash(data: data)
        
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    /// Fetches a list of characters from the Marvel API
    ///
    /// - Returns:
    ///     - A Publisher containing an array of Character objects and a possible Error
    func fetchCharacters() -> AnyPublisher<[Character], Error> {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?apikey=\(publicKey)&hash=\(md5Hash)") else {
            return Fail(error: NSError(domain: "Invalid Url", code: 0)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CharacterDataWrapper.self, decoder: JSONDecoder())
            .map({ data in
                guard let data = data.data else {
                    return []
                }
                return data.results ?? []
            })
            .eraseToAnyPublisher()
    }
}

