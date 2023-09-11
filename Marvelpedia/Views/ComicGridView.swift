//
//  ComicView.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/9/23.
//

import SwiftUI

/// A View that presents a grid of Comics
struct ComicGridView: View {
    // MARK: View Model
    @ObservedObject var comicGridVM: ComicGridViewModel
    
    // MARK: Columns for LazyVGrid
    private var columns = [GridItem(.flexible(), spacing: 5),
                           GridItem(.flexible(), spacing: 5),
                           GridItem(.flexible(), spacing: 5)]
    
    init(comicGridVM: ComicGridViewModel) {
        self.comicGridVM = comicGridVM
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(comicGridVM.comics, id: \.id) { comic in
                    let imageUrlString = String("\(comic.thumbnail.path).\(comic.thumbnail.fileExtension)")
                    
                    AsyncImage(url: URL(string: imageUrlString)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
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
            comicGridVM.getComics(character: comicGridVM.character)
        }
    }
}

//struct ComicView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicGridView()
//    }
//}
