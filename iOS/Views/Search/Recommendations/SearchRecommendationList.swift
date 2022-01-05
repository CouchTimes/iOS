//
//  SearchRecommendationList.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 16.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendationList: View {
    var title: String
    var shows: [ShowDetailsResponse]

    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color("captionColor"))
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: 16) {
                    if shows.count > 0 {
                        ForEach(shows, id: \.id) { show in
                            SearchRecommendationItem(show: show, savedShowIds: searchViewModel.savedShows)
                        }
                    } else {
                        ForEach(0 ..< 20) { _ in
                            Rectangle()
                                .fill(Color("dividerColor"))
                                .frame(width: 128, height: 192)
                                .cornerRadius(6)
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}
