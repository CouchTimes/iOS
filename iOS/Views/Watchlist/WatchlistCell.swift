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
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 16) {
                    WatchlistCover(cover: show.poster)
                    VStack(alignment: .leading, spacing: 4) {
                        ItemTitle(text: show.title)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        Caption(text: show.nextEpisodeToWatch)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }.padding(.trailing, 16)
                Spacer()
                ZStack {
                    Text(count)
                        .font(.system(.footnote))
                        .fontWeight(.bold)
                        .foregroundColor(Color("titleColor"))
                        .frame(width: 40, height: 32)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(Color("borderColor"), lineWidth: 2)
                        )
                }
            }
            NavigationLink(destination: ShowDetailsView(show: show)) {
                EmptyView()
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

extension WatchlistCell {
    var count: String {
        String(describing: show.episodeCount)
    }
}
