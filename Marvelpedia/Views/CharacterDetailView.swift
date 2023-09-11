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
    
    // MARK: Button Selector
    @State var selectedButton: CharacterDetailViewModel.TabSelectionOption = .comics
    
    var body: some View {
        NavigationStack {
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
                    .frame(height: 25)
                
                // MARK: Comic/Event Tab Options
                HStack {
                    
                    Button {
                        selectedButton = .comics
                    } label: {
                        VStack {
                            Image(systemName: "book")
                                .font(.system(size: 25))
                            Text(String(character.comics.available))
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                        }
                        .cornerRadius(5)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                    }
                    .buttonStyle(CustomButtonStyle(selected: selectedButton == .comics))
                    .tint(selectedButton == .comics ? .black : Color(UIColor.lightGray))
                    .frame(width: 150, height: 50)
                    
                    Button {
                        selectedButton = .events
                    } label: {
                        VStack {
                            Image(systemName: "tv")
                                .font(.system(size: 25))
                            Text(String(character.events.available))
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                        }
                        .cornerRadius(5)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                    }
                    .buttonStyle(CustomButtonStyle(selected: selectedButton == .events))
                    .tint(selectedButton == .events ? .black : Color(UIColor.lightGray))
                    .frame(width: 150, height: 50)
                }
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: Comic/Event View
                if selectedButton == .comics {
                    ComicGridView(comicGridVM: ComicGridViewModel(character: character))
                } else {
                    EventGridView(eventGridVM: EventGridViewModel(character: character))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // ... Top Right "Ellipsis" Button
                } label: {
                    Label("", systemImage: "ellipsis")
                        .foregroundColor(.black)
                }
            }
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

// MARK: Custom Button
struct CustomButtonStyle: PrimitiveButtonStyle {
    var selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        if selected {
            Button(configuration)
                .buttonStyle(.bordered)
        } else {
            Button(configuration)
                .buttonStyle(.borderless)
        }
    }
}

// MARK: Navigation Controller
extension UINavigationController {
    
    // Remove "back" on navigation button
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
