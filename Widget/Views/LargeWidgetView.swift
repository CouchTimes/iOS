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
                HStack(alignment: .center, spacing: 20) {
                    Image(uiImage: UIImage(data: show.poster!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 60)
                        .cornerRadius(4)
                    VStack(alignment: .leading, spacing: 10) {
                        ItemTitle(text: show.title)
                            .foregroundColor(Color("titleColor"))
                            .lineLimit(2)
                            .truncationMode(.tail)
                        Caption(text: show.nextEpisodeToWatch)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    Spacer()
                    ZStack {
                        Text(String(describing: show.episodeCount))
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
