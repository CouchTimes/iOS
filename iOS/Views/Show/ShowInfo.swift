//
//  ShowInfo.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfo: View {
    var genre: String
    var rating: String
    var status: String

    var body: some View {
        HStack {
            ShowInfoBlock(label: "Genre", value: genre)
            ShowInfoBlockDivider()
            ShowInfoBlock(label: "Rating", value: rating)
            ShowInfoBlockDivider()
            ShowInfoBlock(label: "Status", value: status)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

struct ShowInfo_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfo(genre: "Drama", rating: "8.6", status: "Returning")
    }
}
