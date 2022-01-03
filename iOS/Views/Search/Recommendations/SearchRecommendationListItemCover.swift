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

    var poster: Image {
        if let poster = show.poster_data {
            return Image(uiImage: UIImage(data: poster)!)
        }

        return Image("cover_placeholder")
    }

    var body: some View {
        poster
            .resizable()
            .scaledToFill()
            .frame(width: 128, height: 192)
            .cornerRadius(6)
    }
}
