//
//  Library.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 24.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct Library: View {
    @State private var searchText: String = ""
    @State private var libraryViewState = 0
    @ObservedObject var viewModel = LibraryViewModel()
    
    private var didManagedObjectContextSave = NotificationCenter.default
        .publisher(for: .NSManagedObjectContextDidSave)
        .receive(on: RunLoop.main)

    private var didStoreRemoteChange = NotificationCenter.default
        .publisher(for: .NSPersistentStoreRemoteChange)
        .receive(on: RunLoop.main)
    
    let layout = [
        GridItem(.flexible(minimum: 96), spacing: 20),
        GridItem(.flexible(minimum: 96), spacing: 20),
        GridItem(.flexible(minimum: 96))
    ]
    
    var shows: [Show] {
        if libraryViewState == 0 {
            if searchText.isEmpty {
                return viewModel.allShows
            } else {
                return viewModel.allShows.filter { $0.title.contains(searchText) }
            }
        } else {
            if searchText.isEmpty {
                return viewModel.favoriteShows
            } else {
                return viewModel.favoriteShows.filter { $0.title.contains(searchText) }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if shows.count > 0 {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, alignment: .center) {
                            ForEach(shows, id: \.objectID) { show in
                                NavigationLink(destination: ShowDetailsView(show: show)) {
                                    LibraryItem(show: Binding.constant(show))
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top, 8)
                        .padding(.horizontal)
                    }
                } else {
                    if libraryViewState == 0 {
                        EmptyState(title: "All your shows in one place",
                                   text: "Shows you added to CouchTimes will always be available in your Library. You can always have a big Library, while keeping your Watchlist focused.",
                                   iconName: "square.3.stack.3d")
                    } else {
                        EmptyState(title: "All your favorite shows",
                                   text: "This is the place for all the shows you marked as your favorites.",
                                   iconName: "star.fill")
                    }
                }
                CustomSegmentedControl(selection: $libraryViewState, size: CGSize(width: UIScreen.main.bounds.width, height: 44), segmentLabels: ["All", "Favorites"])
                    .padding(.bottom, 16)
            }
            .navigationBarTitle("Library")
            .searchable(text: $searchText, placement: .automatic, prompt: "Search")
        }
        .onReceive(self.didManagedObjectContextSave) { _ in
            viewModel.fetchAllShows()
            viewModel.fetchFavoriteShows()
        }
        .onReceive(self.didStoreRemoteChange) { _ in
            viewModel.fetchAllShows()
            viewModel.fetchFavoriteShows()
        }
    }
}
