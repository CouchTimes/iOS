//
//  MediumWidgetView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 29.12.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct MediumWidgetView: View {
    var entry: Provider.Entry
    
    var shows: ArraySlice<Show> {
        let shows = entry.shows.prefix(4)
        return shows
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ForEach(shows, id: \.self) { show in
                VStack(alignment: .center, spacing: 8) {
                    Image(uiImage: UIImage(data: show.poster!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 64, height: 96)
                        .cornerRadius(4)
                    Group {
                        Text(show.nextEpisodeToWatchOnlyPrefixes)
                            .foregroundColor(Color("titleColor"))
                            .font(.system(.subheadline))
                            .fontWeight(.semibold)
                    }
                    .lineLimit(1)
                    .truncationMode(.tail)
                }
            }
            
            if shows.count < 4 {
                Spacer()
            }
        }.padding()
    }
}

//struct MediumWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediumWidgetView()
//    }
//}
