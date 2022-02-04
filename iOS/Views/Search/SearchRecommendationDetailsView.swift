//
//  SearchRecommendationDetailsView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 04.02.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendationDetailsView: View {
    var title: String
    var type: SearchRecommendationType
    
    @EnvironmentObject var searchViewModel: SearchViewModel
    
    var body: some View {
        Group {
            if searchViewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .foregroundColor(Color.white)
                        .frame(width: 32, height: 32, alignment: .center)
                    Spacer()
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(searchViewModel.searchedShows, id: \.id) { show in
                            SearchResultItem(show: show, savedShowIds: searchViewModel.savedShows)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            searchViewModel.getSearchRecommendations(type: type)
        }
    }
}
