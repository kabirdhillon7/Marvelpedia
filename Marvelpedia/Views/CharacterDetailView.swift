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
                                        .frame(maxWidth: 80, maxHeight: 80)
                                case .empty:
                                    ProgressView()
                                case .failure(_):
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                        }
                        Spacer()
                            .frame(height: 20)
                        
                        Text(character.description.prefix(100))
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .frame(alignment: .leading)
                        
                        Spacer()
                            .frame(height: 30)
                    }
                }
                .groupBoxStyle(CustomGroupBox())
                .padding()
                
                Spacer()
                    .frame(height: 30)
                
                // MARK: Comic/Event Tab Options
                HStack {
                    
                    Button {
                        selectedButton = .comics
                    } label: {
                        VStack {
                            Image(systemName: selectedButton == .comics ? "book.fill" : "book")
                                .font(.system(size: 20))
                            Spacer()
                                .frame(height: 5)
                            Text(String(character.comics.available))
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                        }
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                    .cornerRadius(15)
                    .buttonStyle(CustomButtonStyle(selected: selectedButton == .comics))
                    .tint(selectedButton == .comics ? .black : Color(UIColor.lightGray))
                    .frame(width: 125, height: 50)
                    
                    Button {
                        selectedButton = .events
                    } label: {
                        VStack {
                            Image(systemName: selectedButton == .events ? "tv.fill" : "tv")
                                .font(.system(size: 20))
                            Spacer()
                                .frame(height: 5)
                            Text(String(character.events.available))
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                        }
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                    .cornerRadius(15)
                    .buttonStyle(CustomButtonStyle(selected: selectedButton == .events))
                    .tint(selectedButton == .events ? .black : Color(UIColor.lightGray))
                    .frame(width: 125, height: 50)
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
                .padding(.trailing, 5)
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
                    .shadow(radius: 3)
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
    
    // Removes "back" on navigation button
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
