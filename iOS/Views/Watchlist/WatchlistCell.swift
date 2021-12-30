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
    @Binding var show: Show

    var body: some View {
        NavigationLink(destination: ShowDetail(show: show)) {
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
    }
}

extension WatchlistCell {
    var count: String {
        String(describing: show.episodeCount)
    }
}
