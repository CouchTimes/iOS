//
//  WatchlistCellEpisodeCounter.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct WatchlistCellEpisodeCounter: View {
    var text: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Text(text)
                .font(.system(.footnote))
                .fontWeight(.bold)
                .foregroundColor(Color("titleColor"))
                .frame(width: 40, height: 32)
                .background(Color("backgroundColor"))
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.tail)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color("borderColor"), lineWidth: 2)
                )
        }
    }
}

struct WatchlistCellEpisodeCounter_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCellEpisodeCounter(text: "24")
    }
}
