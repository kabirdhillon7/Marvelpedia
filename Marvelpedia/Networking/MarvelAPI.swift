//
//  APICaller.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import Foundation
import CryptoKit

/// A protocol that defines the methods for accessing data from the Marvel API.
protocol MarvelAPIDataServicing {
    
    /// Calculates the MD5 hash of a string.
    ///
    /// - Parameter string: The string to calculate the MD5 hash of.
    /// - Returns: The MD5 hash of the string.
    func MD5(string: String) -> String
    
    /// Fetches a list of characters from the Marvel API.
    ///
    /// - Parameter offset: The offset of the first character to fetch.
    /// - Parameter completion: A completion handler that is called with the results of the fetch operation.
    func fetchCharacters(offset: Int, completion: @escaping ([Character]?, Error?) -> Void)
    
    /// Fetches a list of comics from the Marvel API.
    ///
    /// - Parameter id: The ID of the character to fetch comics for.
    /// - Parameter completion: A completion handler that is called with the results of the fetch operation.
    func fetchComics(id: Int, completion: @escaping ([Comic]?, Error?) -> Void)
    
    /// Fetches a list of events from the Marvel API.
    /// 
    /// - Parameter id: The ID of the character to fetch events for.
    /// - Parameter completion: A completion handler that is called with the results of the fetch operation.
    func fetchEvents(id: Int, completion: @escaping ([Event]?, Error?) -> Void)
}

/// An enum that defines errors for the Marvel API
enum MarvelAPIError: Error {
    case invalidURL
    case networkError
    case jsonDecodeError
    case marvelAPIError(code: Int, message: String)
}

/// A struct that defines the methods for accessing data from the Marvel API.
struct MarvelAPI {
    
    /// Public API Key
    let publicKey = Bundle.main.infoDictionary?["PUBLIC_API_KEY"] as? String ?? ""
    /// Private API Key
    let privateKey = Bundle.main.infoDictionary?["PRIVATE_API_KEY"] as? String ?? ""
    
    /// Calculates the MD5 hash of a string.
    ///
    /// - Parameter string: A string containing a timestamp, private API key, and public API key.
    /// - Returns: The MD5 hash of the string.
    func MD5(string: String) -> String {
        guard let data = string.data(using: .utf8) else {
            return ""
        }
        let md5 = Insecure.MD5.hash(data: data)
        return md5.compactMap { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Fetches a list of characters from the Marvel API and returns an array of Character objects.
    ///
    /// - Parameter offset: An interger which is the requested number of skipped results of the call.
    /// - Returns: An array of Character objects or nil if an error occurs.
    func fetchCharacters(offset: Int, completion: @escaping ([Character]?, Error?) -> Void) {
        let timestamp: String = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(privateKey)\(publicKey)")
        
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)&offset=\(offset)") else {
            completion(nil, MarvelAPIError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completion(nil, MarvelAPIError.networkError)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(CharacterDataWrapper.self, from: data)
                completion(result.data.results, nil)
            } catch {
                print("\(MarvelAPIError.jsonDecodeError) -- Error fetching characters: \(error)")
                completion(nil, MarvelAPIError.jsonDecodeError)
            }
        }
        task.resume()
    }
    
    /// Fetches a list of events from the Marvel API and returns an array of Comic objects.
    ///
    /// - Parameter id: The character id.
    /// - Returns: An array of Comic objects or nil if an error occurs.
    func fetchComics(id: Int, completion: @escaping ([Comic]?, Error?) -> Void) {
        let timestamp: String = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(privateKey)\(publicKey)")
        
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)/comics?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)") else {
            completion(nil, MarvelAPIError.invalidURL)
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completion(nil, MarvelAPIError.networkError)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let dataWrapper = try decoder.decode(ComicDataWrapper.self, from: data)
                completion(dataWrapper.data.results, error)
                
            } catch {
                print("\(MarvelAPIError.jsonDecodeError) -- Error fetching comics: \(error)")
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    /// Fetches a list of events from the Marvel API and returns an array of Event objects.
    ///
    /// - Parameter id: The character id.
    /// - Returns: An array of Event objects or nil if an error occurs.
    func fetchEvents(id: Int, completion: @escaping ([Event]?, Error?) -> Void) {
        let timestamp: String = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(privateKey)\(publicKey)")
        
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)/events?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)") else {
            completion(nil, MarvelAPIError.invalidURL)
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completion(nil, MarvelAPIError.networkError)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let dataWrapper = try decoder.decode(EventDataWrapper.self, from: data)
                completion(dataWrapper.data.results, error)
                
            } catch {
                print("\(MarvelAPIError.jsonDecodeError) -- Error fetching events: \(error)")
                completion(nil, MarvelAPIError.jsonDecodeError)
            }
        }
        task.resume()
    }
}
