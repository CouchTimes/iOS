//
//  SearchRecommendations.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 16.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendations: View {
    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 12) {
                    SearchRecommendationListItem(title: "Popular Shows", type: SearchRecommendationType.popular)
                    SearchRecommendationListItem(title: "Best Rated Shows", type: SearchRecommendationType.topRated)
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text("Networks")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color("captionColor"))
                    VStack(alignment: .leading, spacing: 12) {
                        SearchRecommendationListItem(title: "Netlifx", type: SearchRecommendationType.netflix)
                        SearchRecommendationListItem(title: "Apple TV+", type: SearchRecommendationType.apple)
                        SearchRecommendationListItem(title: "HBO", type: SearchRecommendationType.hbo)
                        SearchRecommendationListItem(title: "Disney+", type: SearchRecommendationType.disney)
                        SearchRecommendationListItem(title: "Amazon", type: SearchRecommendationType.amazon)
                        SearchRecommendationListItem(title: "Hulu", type: SearchRecommendationType.hulu)
                        SearchRecommendationListItem(title: "Showtime", type: SearchRecommendationType.showtime)
                        SearchRecommendationListItem(title: "SyFy", type: SearchRecommendationType.syfy)
                    }
                }
            }.padding()
        }
    }
}
