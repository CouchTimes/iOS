//
//  ContentView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import Combine
import SwiftUI
import CoreData

struct Watchlist: View {
    @State private var query: String = ""
    @State private var isPresented = false
    @State private var showSorting: ShowFilter = .byEpisodesAsc
    @ObservedObject var viewModel = WatchlistViewModel()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    private var didManagedObjectContextSave = NotificationCenter.default
        .publisher(for: .NSManagedObjectContextDidSave)
        .receive(on: RunLoop.main)

    private var didStoreRemoteChange = NotificationCenter.default
        .publisher(for: .NSPersistentStoreRemoteChange)
        .receive(on: RunLoop.main)

    let layout = [
        GridItem(.flexible())
    ]
    
    private var filteredShows: [Show] {
        switch showSorting {
        case .byEpisodesAsc:
            return viewModel.shows.sorted { $0.episodeCount < $1.episodeCount }
        case .byNameAsc:
            return viewModel.shows.sorted { $0.title < $1.title }
        }
    }

    var body: some View {
        NavigationView {
            WatchlistList(shows: filteredShows, showsCount: viewModel.shows.count)
            .navigationBarTitle("Watchlist", displayMode: .large)
            .navigationBarItems(leading: NavigationLink(destination: Settings().accentColor(Color("tintColor"))) {
                Image(systemName: "gearshape")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(Color("tintColor"))
            }, trailing: Menu {
                Button(action: sortShowsByEpisodesAsc) {
                    if showSorting == .byEpisodesAsc {
                        Image(systemName: "checkmark.circle")
                    }

                    Text("Episodes")
                }

                Button(action: sortShowsByNameAsc) {
                    if showSorting == .byNameAsc {
                        Image(systemName: "checkmark.circle")
                    }
                    
                    Text("Alphabetical")
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(Color("tintColor"))
            })
            .searchable(text: $query, placement: .automatic, prompt: "Search")
            .refreshable {
                await viewModel.updateShows()
            }
        }
        
        .onReceive(self.didManagedObjectContextSave) { _ in
            viewModel.fetchAllShows()
        }
        .onReceive(self.didStoreRemoteChange) { _ in
            viewModel.fetchAllShows()
        }
    }

    private func sortShowsByEpisodesAsc() {
        showSorting = .byEpisodesAsc
    }

    private func sortShowsByNameAsc() {
        showSorting = .byNameAsc
    }
}

enum ShowFilter {
    case byEpisodesAsc
    case byNameAsc
}
