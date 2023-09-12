//
//  EventGridViewModel.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/10/23.
//

import Foundation

final class EventGridViewModel: ObservableObject {
    // MARK: Selected Character
    var character: Character!
    
    // MARK: Event Array
    @Published var events = [Event]()
    
    // MARK: Networking
    private let marvelCaller: MarvelAPI = MarvelAPI()
    
    init(character: Character) {
        self.character = character
    }
    
    /// Fetches a list of events from the Marvel API and returns an array of Event objects.
    ///
    /// - Parameter character: The selected character.
    func getEvents(character: Character) {
        marvelCaller.fetchEvents(id: character.id) { events, error in
            if let events = events {
                self.events = events
            }
            
            if let error = error {
                print("Error retrieving events: \(error)")
            }
        }
    }
}
