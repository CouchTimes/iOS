//
//  SearchResults.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 16.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchResults: View {
    var query: String
    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        if searchViewModel.isLoading {
            VStack {
                Spacer()
                SearchLoading()
                Spacer()
            }
        } else {
            if searchViewModel.searchedShows.count > 0 && !query.isEmpty  {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(searchViewModel.searchedShows, id: \.id) { show in
                            SearchResultItem(show: show, savedShowIds: searchViewModel.savedShows)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            } else if searchViewModel.searchedShows.count == 0 && !query.isEmpty {
                VStack {
                    Spacer()
                    SearchLoading()
                    Spacer()
                }
            } else {
                EmptyState(title: "No shows found",
                           text: "Try searching for a different name or show you are looking for.",
                           iconName: "eyeglasses")
            }
        }
    }
}
