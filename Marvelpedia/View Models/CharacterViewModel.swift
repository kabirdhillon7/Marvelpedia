//
//  CharacterViewModel.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/6/23.
//

import Foundation
import SwiftUI

/// Manages the data for CharacterView
final class CharacterViewModel: ObservableObject {
    
    // MARK: Character Array
    @Published var characters = [Character]()
    
    // MARK: Networking
    private let apiCaller: APICaller = APICaller()
    
    /// Updates Character array with results from API call
    func getCharacters() {
        apiCaller.fetchCharacters { characters, error in
            if let characters = characters {
                self.characters = characters
            }
            
            if let error = error {
                print("Error retrieving characters: \(error)")
            }
        }
    }
}
