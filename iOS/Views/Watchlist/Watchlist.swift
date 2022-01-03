//
//  ContentView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI
import CoreData

struct Watchlist: View {
    @State private var searchText: String = ""
    @State private var showSorting: ShowFilter = .episodesAscending
    @ObservedObject private var viewModel = WatchlistViewModel()
    
    @Environment(\.isSearching) private var isSearching: Bool
    
    private var didManagedObjectContextSave = NotificationCenter.default
        .publisher(for: .NSManagedObjectContextDidSave)
        .receive(on: RunLoop.main)

    private var didStoreRemoteChange = NotificationCenter.default
        .publisher(for: .NSPersistentStoreRemoteChange)
        .receive(on: RunLoop.main)

    let layout = [
        GridItem(.flexible())
    ]
    
    private var shows: [Show] {
        if searchText.isEmpty {
            switch showSorting {
            case .episodesAscending:
                return viewModel.shows.sorted { $0.episodeCount < $1.episodeCount }
            case .episodesDescending:
                return viewModel.shows.sorted { $0.title > $1.title }
            case .nameAscending:
                return viewModel.shows.sorted { $0.title < $1.title }
            case .nameDescending:
                return viewModel.shows.sorted { $0.title > $1.title }
            }
        } else {
            return viewModel.shows.filter { $0.title.contains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            WatchlistList(shows: shows, showsCount: viewModel.shows.count)
            .navigationBarTitle("Watchlist", displayMode: .large)
            .navigationBarItems(leading: NavigationLink(destination: Settings().tint(Color("titleColor"))) {
                Image(systemName: "gearshape")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(Color("captionColor"))
            }, trailing: Menu {
                Menu {
                    Button(action: sortShowsByAscendingEpisodes) {
                        if showSorting == .episodesAscending {
                            Image(systemName: "checkmark.circle")
                        }

                        Text("Ascending")
                    }

                    Button(action: sortShowsByDescendingEpisodes) {
                        if showSorting == .episodesDescending {
                            Image(systemName: "checkmark.circle")
                        }
                        
                        Text("Descending")
                    }
                } label: {
                    Text("Episodes To Watch")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(Color("tintColor"))
                }
                Menu {
                    Button(action: sortShowsByAscendingNames) {
                        if showSorting == .nameAscending {
                            Image(systemName: "checkmark.circle")
                        }

                        Text("Ascending")
                    }

                    Button(action: sortShowsByDescendingName) {
                        if showSorting == .nameDescending {
                            Image(systemName: "checkmark.circle")
                        }
                        
                        Text("Descending")
                    }
                } label: {
                    Text("Alphabetical")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(Color("tintColor"))
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(Color("captionColor"))
            })
            .searchable(text: $searchText, placement: .automatic, prompt: "Search")
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

    private func sortShowsByAscendingEpisodes() {
        showSorting = .episodesAscending
    }

    private func sortShowsByDescendingEpisodes() {
        showSorting = .episodesDescending
    }
    
    private func sortShowsByAscendingNames() {
        showSorting = .nameAscending
    }

    private func sortShowsByDescendingName() {
        showSorting = .nameDescending
    }
}

enum ShowFilter {
    case episodesAscending
    case episodesDescending
    case nameAscending
    case nameDescending
}
