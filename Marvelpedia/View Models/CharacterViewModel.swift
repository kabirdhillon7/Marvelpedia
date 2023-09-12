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
    
    // MARK: Offset
    var offset: Int = 0
    
    // MARK: View State
    @Published var viewState: ViewState?
    
    // MARK: Networking
    private let marvelCaller: MarvelAPI = MarvelAPI()
    
    // MARK: View State enum
    enum ViewState {
        case fetching
        case loading
        case finished
    }
    
    /// Updates Character array with results from API call
    func getCharacters() {
        reset()
        marvelCaller.fetchCharacters(offset: offset) { characters, error in
            self.viewState = .loading
            
            if let characters = characters {
                self.characters = characters
                self.viewState = .finished
            }
            
            if let error = error {
                print("Error retrieving characters: \(error)")
            }
        }
    }
    
    /// Updates Character array with additonal results from API call
    func getMoreCharacters() {
        self.offset += 20
        marvelCaller.fetchCharacters(offset: offset) { characters, error in
            self.viewState = .fetching
            if let characters = characters {
                self.characters.append(contentsOf: characters)
                self.viewState = .finished
            }
            
            if let error = error {
                print("Error retrieving additional characters: \(error)")
            }
        }
    }
    
    /// Checks if the last Character item in the Character array is on the View
    func hasReachedEnd(of character: Character) -> Bool {
        guard let characters = self.characters.last else {
            return false
        }
        
        return characters.id == character.id
    }
    
    /// Resets the the Character array, offset, and viewState
    func reset() {
        if viewState == .finished {
            characters.removeAll()
            offset = 0
            viewState = nil
        }
    }
}
