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
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(characterVM.characters, id: \.id) { character in
                    let imageUrlString = String("\(character.thumbnail.path).\(character.thumbnail.fileExtension)")
                    
                    ZStack(alignment: .bottomLeading) {
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
                        Text(character.name)
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                            .padding(.leading, 5)
                            .font(.system(size: 12))
                            .shadow(color: .black, radius: 5)
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
