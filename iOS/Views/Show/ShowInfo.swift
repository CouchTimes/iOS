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
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ShowInfoBlock(label: "Genre", value: genre)
            ShowInfoBlockDivider()
            ShowInfoBlock(label: "Rating", value: rating)
            ShowInfoBlockDivider()
            ShowInfoBlock(label: "Status", value: status)
        }
    }
}

struct ShowInfo_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfo(genre: "Drama", rating: "8.6", status: "Returning")
    }
}
