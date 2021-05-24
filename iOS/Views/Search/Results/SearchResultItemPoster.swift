//
//  SearchResultItemPoster.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchResultItemPoster: View {
    var poster: Image

    var body: some View {
        poster
            .resizable()
            .scaledToFill()
            .frame(width: 48, height: 72)
            .cornerRadius(6)
    }
}

// struct SearchResultItemPoster_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultItemPoster(posterFilePath: "/scoyQvVpyrJIS29dIffRdKgMW9S.jpg")
//    }
// }
