//
//  CharacterDetailView.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/8/23.
//

import SwiftUI

/// A View that presents character details
struct CharacterDetailView: View {
    // MARK: View Model
    @ObservedObject var characterDetailVM: CharacterDetailViewModel
    
    var body: some View {
        if let character = characterDetailVM.character {
            
            // MARK: Character Info
            GroupBox {
                VStack {
                    HStack {
                        Text(character.name)
                            .fontWeight(.regular)
                            .font(.system(size: 21))
                            .foregroundColor(.black)
                            .frame(alignment: .leading)
                            .lineLimit(2)
                        
                        Spacer()
                        
                        let imageString = character.thumbnail.path + "." + character.thumbnail.fileExtension
                        AsyncImage(url: URL(string: imageString)) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable()
                                    .clipShape(Circle())
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 100, maxHeight: 100)
                            case .empty:
                                ProgressView()
                            case .failure(_):
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                    }
                    Text(character.description)
                        .lineLimit(2)
                        .foregroundColor(.black)
                        .font(.body)
                    
                    Text("")
                    Text("")
                }
            }
            .padding()
            .groupBoxStyle(CustomGroupBox())
            
            Spacer()
        }
    }
}

/*
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}*/

// MARK: Custom Group Box
struct CustomGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(radius: 2)
            )
    }
}
