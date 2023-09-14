//
//  ContentView.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import SwiftUI
import CachedAsyncImage

/// A View that presents a grid of Marvel characters
struct CharacterView: View {
    
    // MARK: View Model
    @ObservedObject var characterVM = CharacterViewModel()
    
    // MARK: View Has Appeared Check
    @State var hasAppeared = false
        
    // MARK: Columns for LazyVGrid
    private var columns = [GridItem(.flexible(), spacing: 1),
                           GridItem(.flexible(), spacing: 1),
                           GridItem(.flexible(), spacing: 1)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(characterVM.characters, id: \.id) { character in
                        let imageUrlString = String("\(character.thumbnail.path).\(character.thumbnail.fileExtension)")
                        
                        NavigationLink(destination: CharacterDetailView(characterDetailVM: CharacterDetailViewModel(character: character))) {
                            ZStack(alignment: .bottomLeading) {
                                
                                CachedAsyncImage(url: URL(string: imageUrlString), urlCache: .imageCache) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                    case .empty:
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                    case .failure(_):
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                    @unknown default:
                                        EmptyView()
                                            .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                                
                                Text(character.name)
                                    .frame(alignment: .leading)
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                    .padding(.bottom, 5)
                                    .padding(.leading, 5)
                                    .font(.system(size: 12))
                                    .shadow(color: .black, radius: 5)
                            }
                            .task {
                                if characterVM.hasReachedEnd(of: character) && characterVM.viewState != .fetching {
                                    characterVM.getMoreCharacters()
                                }
                            }
                        }
                    }
                }
            }
            .task {
                if !hasAppeared {
                    characterVM.getCharacters()
                    hasAppeared = true
                }
            }
            .refreshable {
                characterVM.getCharacters()
            }
            .overlay(alignment: .bottom) {
                if characterVM.viewState == .fetching {
                    ProgressView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}

// MARK: URL Cache
extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
