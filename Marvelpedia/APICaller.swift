//
//  APICaller.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import Foundation
import CryptoKit

struct APICaller {
    
    // MARK: API Keys
    let publicKey = Bundle.main.infoDictionary?["PUBLIC_API_KEY"] as? String ?? ""
    let privateKey = Bundle.main.infoDictionary?["PRIVATE_API_KEY"] as? String ?? ""
    
    // MARK: MD5 Hash
    func MD5(string: String) -> String {
        guard let data = string.data(using: .utf8) else {
            return ""
        }
        let md5 = Insecure.MD5.hash(data: data)
        return md5.compactMap { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Fetches a list of characters from the Marvel API and returns an array of Character objects.
    ///
    /// - Returns:
    ///     - An array of Character objects or nil if an error occurs.
    ///
    func fetchCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
        let timestamp: String = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(privateKey)\(publicKey)")
        
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)") else {
            completion(nil,nil)
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(CharacterDataWrapper.self, from: data)
                completion(result.data.results, nil)
            } catch {
                print("Error fetching characters: \(error)")
                completion(nil, error)
            }
        }
        task.resume()
    }
}
