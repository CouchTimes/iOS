//
//  ShowInfoBox.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfoBox: View {
    var poster: Image
    var title: String
    var subtitle: String?
    var genre: String
    var rating: String
    var status: String

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            ShowInfoCover(poster: poster)
                .padding(.top, 16)
            ShowInfoTitle(title: title, subtitle: subtitle)
                .padding(.horizontal, 16)
            ShowInfo(genre: genre, rating: rating, status: status)
        }
    }
}

struct ShowInfoBox_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfoBox(poster: Image("cover_placeholder"), title: "Insecure", subtitle: "2017", genre: "Drama", rating: "9.0", status: "Returning")
    }
}
