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
            VStack {
                VStack(alignment: .leading, spacing: 24) {
                    SearchRecommendationList(title: "Popular Shows", shows: searchViewModel.popularShows)
                    SearchRecommendationList(title: "Top Rated Shows", shows: searchViewModel.topRatedShows)
                    SearchRecommendationList(title: "Netlifx", shows: searchViewModel.netflixShows)
                    SearchRecommendationList(title: "Apple TV+", shows: searchViewModel.appleShows)
                    SearchRecommendationList(title: "Disney+", shows: searchViewModel.disneyShows)
                    SearchRecommendationList(title: "Amazon", shows: searchViewModel.amazonShows)
                    SearchRecommendationList(title: "HBO", shows: searchViewModel.hboShows)
                }.padding(.bottom, 24)
            }
        }
    }
}

struct SearchRecommendation_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecommendations()
    }
}
