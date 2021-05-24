//
//  LargeWidgetView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 29.12.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct LargeWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(shows, id: \.self) { show in
                HStack(alignment: .center, spacing: 16) {
                    Image(uiImage: UIImage(data: show.poster!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 60)
                        .cornerRadius(4)
                    VStack(alignment: .leading, spacing: 4) {
                        ItemTitle(text: show.title)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        Caption(text: show.nextEpisodeToWatch)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    Spacer()
                    WatchlistCellEpisodeCounter(text: String(describing: show.episodeCount))
                }
            }
            
            if shows.count < 4 {
                Spacer()
            }
        }.padding()
    }
}

extension LargeWidgetView {
    var shows: ArraySlice<Show> {
        let shows = entry.shows.prefix(4)
        return shows
    }
}

//struct LargeWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        LargeWidgetView()
//    }
//}
