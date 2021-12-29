//
//  WatchlistCell.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WatchlistCell: View {
    @State private var isPresented = false
    @Binding var show: Show
    
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            HStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 16) {
                    WatchlistCover(cover: show.poster)
                    WatchlistCellContent(title: show.title, nextEpisode: show.nextEpisodeToWatch)
                }.padding(.trailing, 16)
                Spacer()
                WatchlistCellEpisodeCounter(text: count)
            }
            .frame(maxWidth: .infinity)
            .background(Color("backgroundColor"))
        }
        .sheet(isPresented: $isPresented) {
            ShowDetail(showId: Int(show.tmdbId))
        }.buttonStyle(WatchlistCellButtonStyle())
    }
}

struct WatchlistCellButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
  }
}

extension WatchlistCell {
    var count: String {
        String(describing: show.episodeCount)
    }
}
