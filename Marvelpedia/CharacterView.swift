//
//  ContentView.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/5/23.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var characterVM = CharacterViewModel()
    
    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                
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
