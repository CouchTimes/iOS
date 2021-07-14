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
    @State private var isPresented = false
    @State private var showSorting: ShowFilter = .byEpisodesAsc
    @ObservedObject var viewModel = WatchlistViewModel()
    
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
            Group {
                if viewModel.shows.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: layout, spacing: 16.0) {
                            ForEach(filteredShows, id: \.objectID) { show in
                                WatchlistCell(show: Binding.constant(show))
                            }
                        }.padding(.vertical)
                    }
                } else {
                    EmptyState(title: "Keep track for your shows",
                               text: "Add shows to your Watchlist for quick access. Freshly added shows will automatically also appear in your Watchlist.",
                               iconName: "tv")
                }
            }
            .navigationBarTitle("Watchlist", displayMode: .inline)
            .navigationBarItems(leading: NavigationLink(destination: Settings().accentColor(Color("tintColor"))) {
                Image(systemName: "gearshape")
                    .font(Font.system(size: 20, weight: .bold))
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
                    .font(Font.system(size: 20, weight: .bold))
                    .foregroundColor(Color("tintColor"))
            })
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
