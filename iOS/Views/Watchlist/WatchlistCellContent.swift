//
//  WatchlistCellContent.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct WatchlistCellContent: View {
    var title: String
    var nextEpisode: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ItemTitle(text: title)
                .lineLimit(2)
                .truncationMode(.tail)
            Caption(text: nextEpisode)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
}

struct WatchlistCellContent_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCellContent(title: "Fleabag", nextEpisode: "S01E01: Episode 01")
    }
}
