//
//  SmallWidgetView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 29.12.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SmallWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(uiImage: imageData)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 53, height: 80)
                .cornerRadius(4)
            VStack(alignment: .leading, spacing: 2) {
                Group {
                    Text(show.title)
                        .foregroundColor(Color("titleColor"))
                        .font(.system(.subheadline))
                        .fontWeight(.semibold)
                    Text(show.nextEpisodeToWatch)
                        .foregroundColor(Color("captionColor"))
                        .font(.system(.caption))
                        .fontWeight(.medium)
                }
                .lineLimit(1)
                .truncationMode(.tail)
            }
        }.padding()
    }
}

extension SmallWidgetView {
    var show: Show {
        return entry.shows.first!
    }
    
    var imageData: UIImage {
        if let data = show.poster {
            return UIImage(data: data)!
        }

        return UIImage(named: "cover_placeholder")!
    }
}
