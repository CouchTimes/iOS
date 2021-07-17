//
//  SearchRecommendationListItemCover.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 16.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendationListItemCover: View {
    var show: ShowDetailsResponse

    var posterURL: URL? {
        if let posterPath = show.poster_path {
            return URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: posterPath))")!
        } else {
            return nil
        }
    }

    var body: some View {
        if posterURL != nil {
            AsyncImage(url: posterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "wifi.slash")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 128, height: 192)
            .cornerRadius(6)
        } else {
            Image("cover_placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 192)
                .cornerRadius(6)
        }
    }
}

// struct SearchRecommendationListItemCover_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchRecommendationListItemCover()
//    }
// }
