//
//  WatchlistList.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 28.12.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WatchlistList: View {
    @Binding var shows: [Show]
    var showsCount: Int
    
    @State private var showingAlert = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        if showsCount > 0 {
            List(shows, id: \.objectID) { show in
                WatchlistCell(show: Binding.constant(show))
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        if show.nextEpisode != nil {
                            managedObjectContext.performAndWait {
                                show.nextEpisode!.watched = true
                                do {
                                    try managedObjectContext.save()
                                    show.objectWillChange.send()
                                    WidgetCenter.shared.reloadAllTimelines()
                                } catch {
                                    print(error)
                                }
                            }
                        } else {
                            showingAlert = true
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                    }.tint(.green)
                }
            }
            .listStyle(.plain)
            .alert("You already watched all availabe episodes", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        } else {
            EmptyState(title: "Keep track for your shows",
                       text: "Add shows to your Watchlist for quick access. Freshly added shows will automatically also appear in your Watchlist.",
                       iconName: "tv")
        }
    }
}
