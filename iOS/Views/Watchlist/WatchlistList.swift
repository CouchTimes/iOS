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
    var shows: [Show]
    var showsCount: Int
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        if showsCount > 0 {
            List(shows, id: \.objectID) { show in
                WatchlistCell(show: Binding.constant(show))
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        managedObjectContext.performAndWait {
                            show.nextEpisode!.watched = true
                            do {
                                try managedObjectContext.save()
                                WidgetCenter.shared.reloadAllTimelines()
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                    }.tint(.green)
                }
            }
            .listStyle(.plain)
        } else {
            EmptyState(title: "Keep track for your shows",
                       text: "Add shows to your Watchlist for quick access. Freshly added shows will automatically also appear in your Watchlist.",
                       iconName: "tv")
        }
    }
}
