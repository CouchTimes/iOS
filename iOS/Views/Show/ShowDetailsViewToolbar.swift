//
//  ShowDetailsViewToolbar.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 02.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowDetailsViewToolbar: View {
    @State private var showShareSheet = false
    @Binding var presentationMode: PresentationMode
    @Binding var showViewModel: ShowViewModel

    var body: some View {
        if showViewModel.show != nil {
            HStack(alignment: .center) {
                Button(action: {
                    $presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 20, weight: .bold))
                        .frame(minWidth: 96.0, minHeight: 48.0, alignment: .leading)
                }
                Spacer()
                Menu {
                    if !showViewModel.watchedStatus {
                        Section {
                            Button(action: {
                                showViewModel.markAllEpisodesAsWatched()
                                showViewModel.showWatched()
                            }) {
                                Label("All Episodes Watched", systemImage: "checkmark.seal")
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            showViewModel.toggleWatchlistStatus()
                        }) {
                            if showViewModel.show!.isActive {
                                Label("Remove from Watchlist", systemImage: "minus.square")
                            } else {
                                Label("Add to Watchlist", systemImage: "plus.square")
                            }
                        }
                        Button(action: {
                            showViewModel.toggleFavoriteStatus()
                        }) {
                            if showViewModel.show!.isFavorite {
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
                        Button(action: {
                            showViewModel.deleteShow()
                            self.$presentationMode.wrappedValue.dismiss()
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
            .padding(.horizontal)
            .foregroundColor(Color("titleColor"))
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [URL(string: "https://www.themoviedb.org/tv/\(showViewModel.show!.tmdbId)")!])
            }
        }
    }
}
