//
//  ComicGridViewModel.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/10/23.
//

import Foundation

final class ComicGridViewModel: ObservableObject {
    // MARK: Selected Character
    var character: Character!
    
    // MARK: Comics Array
    @Published var comics = [Comic]()
    
    // MARK: Networking
    private let marvelCaller: MarvelAPI = MarvelAPI()
    
    init(character: Character) {
        self.character = character
    }
    
    /// Fetches a list of comics from the Marvel API and returns an array of Comic objects.
    ///
    /// - Parameter character: The selected character.
    func getComics(character: Character) {
        marvelCaller.fetchComics(id: character.id) { comics, error in
            if let comics = comics {
                self.comics = comics
            }
            
            if let error = error {
                print("Error retrieving comics: \(error)")
            }
        }
    }
}
