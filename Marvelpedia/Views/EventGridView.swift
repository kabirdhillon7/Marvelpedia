//
//  EventGridView.swift
//  Marvelpedia
//
//  Created by Kabir Dhillon on 9/10/23.
//

import SwiftUI

/// A View that presents a grid of Events
struct EventGridView: View {
    // MARK: View Model
    @ObservedObject var eventGridVM: EventGridViewModel
    
    // MARK: Columns for LazyVGrid
    private var columns = [GridItem(.flexible(), spacing: 5),
                           GridItem(.flexible(), spacing: 5),
                           GridItem(.flexible(), spacing: 5)]
    
    init(eventGridVM: EventGridViewModel) {
        self.eventGridVM = eventGridVM
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(eventGridVM.events, id: \.id) { event in
                    let imageUrlString = String("\(event.thumbnail.path).\(event.thumbnail.fileExtension)")
                    
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
            eventGridVM.getEvents(character: eventGridVM.character)
        }
    }
}


//struct EventGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventGridView()
//    }
//}
