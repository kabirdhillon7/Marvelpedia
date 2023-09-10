//
//  CharacterDetailViewModel.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/8/23.
//

import Foundation

/// Manages the data for CharacterDetailView
final class CharacterDetailViewModel: ObservableObject {
    // MARK: Selected Character
    var character: Character!
    
    init(character: Character) {
        self.character = character
    }
}
