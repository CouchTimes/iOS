//
//  ShowDetailsView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowDetailsView: View {
    var show: Show
    
    @State private var viewMode = 0
    @State private var watchedStatus = true
    @State private var showShareSheet = false
    
    @Environment(\.managedObjectContext) private var managedObjectContext

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                ShowBlurredBackground(poster: Image(uiImage: showImage))
                VStack(spacing: 32) {
                    VStack(spacing: 32) {
                        ShowInfoBox(show: show)
                            .padding(.top, 96)
                        
                        Picker(selection: $viewMode, label: Text("What is your favorite color?")) {
                            Image(systemName: "list.bullet")
                                .tag(0)
                            Image(systemName: "info.circle")
                                .tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Group {
                        if viewMode == 0 {
                            ShowSeasons(show: show)
                        }
                        
                        if viewMode == 1 {
                            ShowInformation(show: show)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 112)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgroundColor"))
            .edgesIgnoringSafeArea(.all)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    if !watchedStatus {
                        Section {
                            Button(action: {
                                self.markAllEpisodesAsWatched()
                                self.getWatchedStatus()
                            }) {
                                Label("All Episodes Watched", systemImage: "checkmark.seal")
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            self.toggleWatchlistStatus()
                        }) {
                            if show.isActive {
                                Label("Remove from Watchlist", systemImage: "minus.square")
                            } else {
                                Label("Add to Watchlist", systemImage: "plus.square")
                            }
                        }
                        Button(action: {
                            self.toggleFavoriteStatus()
                        }) {
                            if show.isFavorite {
                                Label("Remove from Favorites", systemImage: "star.slash.fill")
                            } else {
                                Label("Add to Favorites", systemImage: "star")
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            self.showShareSheet = true
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        Button(role: .destructive, action: {
                            self.deleteShow()
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(Font.system(size: 20, weight: .bold))
                        .frame(minWidth: 96.0, minHeight: 48.0, alignment: .trailing)
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [URL(string: "https://www.themoviedb.org/tv/\(show.tmdbId)")!])
        }
        .onAppear {
            self.getWatchedStatus()
        }
    }
}

extension ShowDetailsView {
    private var showImage: UIImage {
        if let poster = show.poster {
            return UIImage(data: poster)!
        }

        return UIImage(named: "cover_placeholder")!
    }
    
    private func getWatchedStatus() {
        guard let episodesArray = show.getAllEpisodes() else { return }
        let watchableEpisodes = episodesArray.filter { $0.watchable == true }
        var status = true
        
        watchableEpisodes.forEach { episode in
            if !episode.watched {
                status = false
                return
            }
        }
        
        watchedStatus = status
    }
    
    private func markAllEpisodesAsWatched() {
        show.markAllEpisodesAsWatched(managedObjectContext: managedObjectContext)
    }
    
    private func toggleWatchlistStatus() -> Void {
        show.toggleWatchlistMode(managedObjectContext: managedObjectContext)
    }
    
    private func toggleFavoriteStatus() -> Void {
        show.toggleFavoriteMode(managedObjectContext: managedObjectContext)
    }
    
    private func deleteShow() -> Void {
        show.deleteShow(managedObjectContext: managedObjectContext)
    }
}
