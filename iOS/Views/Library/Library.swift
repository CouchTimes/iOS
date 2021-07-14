//
//  Library.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 24.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct Library: View {
    @State private var libraryViewState = 0
    @State private var showingSettings = false
    @ObservedObject var viewModel = LibraryViewModel()
    
    private var didManagedObjectContextSave = NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    private var didStoreRemoteChange = NotificationCenter.default.publisher(for: .NSPersistentStoreRemoteChange)
    
    let layout = [
        GridItem(.adaptive(minimum: 96, maximum: 128)),
    ]
    
    var shows: [Show] {
        if libraryViewState == 0 {
            return viewModel.allShows
        } else {
            return viewModel.favoriteShows
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if shows.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: layout, spacing: 16.0) {
                            ForEach(shows, id: \.objectID) { show in
                                LibraryItem(show: Binding.constant(show))
                            }
                        }.padding()
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
            }
            .navigationBarTitle("Library", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker(selection: $libraryViewState, label: Text("What filter do you want to apply to the library?")) {
                        Text("All").tag(0)
                        Text("Favorites").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
        // TODO: Fix background changes bug
//        .onReceive(self.didManagedObjectContextSave) { _ in
//            viewModel.fetchAllShows()
//            viewModel.fetchFavoriteShows()
//        }
//        .onReceive(self.didStoreRemoteChange) { _ in
//            viewModel.fetchAllShows()
//            viewModel.fetchFavoriteShows()
//        }
        .sheet(isPresented: $showingSettings) {
            Settings().accentColor(Color("tintColor"))
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
