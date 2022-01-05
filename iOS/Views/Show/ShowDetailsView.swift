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
    @State private var showEmptyView = false
    @State private var watchedStatus = true
    @State private var showShareSheet = false
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var managedObjectContext

    var body: some View {
        ZStack(alignment: .bottom) {
            if (!showEmptyView) {
                ScrollView(showsIndicators: false) {
                    ShowBlurredBackground(poster: Image(uiImage: showImage))
                    VStack(spacing: 24) {
                        ShowInformationHero(cover: showImage, title: show.title, year: Int(show.year), genres: show.genres, seasonCount: seasonsCount)
                        Group {
                            if viewMode == 0 {
                                ShowSeasons(show: show, seasonCount: seasonsCount)
                            }
                            
                            if viewMode == 1 {
                                ShowInformation(description: show.wrappedOverview, airs: show.wrappedAirs, runtime: show.wrappedRuntime, network: show.wrappedNetwork, firstAired: show.wrappedFirstAirDate)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 160)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("backgroundColor"))
                .edgesIgnoringSafeArea(.all)
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
                FloatingSegmentedControl(pickerLabel: "What filter do you want to apply to the library?", pickerItems: ["Seasons", "Details"], pickerSelection: $viewMode)
            } else {
                EmptyView()
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [URL(string: "https://www.themoviedb.org/tv/\(show.tmdbId)")!])
        }
        .onAppear {
            self.getWatchedStatus()
        }
        .environmentObject(show)
    }
}

extension ShowDetailsView {
    private var showImage: UIImage {
        if let poster = show.poster {
            return UIImage(data: poster)!
        }

        return UIImage(named: "cover_placeholder")!
    }
    
    private var seasonsCount: Int {
        if let seasons = show.seasons {
            return seasons.count
        }
        
        return 0
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
        self.showEmptyView = true
        self.presentationMode.wrappedValue.dismiss()
        show.deleteShow(managedObjectContext: managedObjectContext)
    }
}
