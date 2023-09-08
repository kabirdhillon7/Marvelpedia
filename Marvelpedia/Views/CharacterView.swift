//
//  ContentView.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import SwiftUI

/// A View that presents a grid of Marvel characters
struct CharacterView: View {
    // MARK: View Model
    @ObservedObject var characterVM = CharacterViewModel()
    
    // MARK: Columns for LazyVGrid
    private var columns = [GridItem(.flexible(), spacing: 1),
                           GridItem(.flexible(), spacing: 1),
                           GridItem(.flexible(), spacing: 1)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(characterVM.characters, id: \.id) { character in
                    let imageUrlString = String("\(character.thumbnail.path).\(character.thumbnail.fileExtension)")
                    
                    AsyncImage(url: URL(string: imageUrlString)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        case .empty:
                            ProgressView()
                        case .failure(_):
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .onAppear {
            characterVM.getCharacters()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
