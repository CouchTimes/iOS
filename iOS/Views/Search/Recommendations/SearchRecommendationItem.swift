//
//  SearchRecommendationItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 27.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendationItem: View {
    var show: ShowDetailsResponse

    @ObservedObject var searchResultItemViewModel: SearchListItemViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        self.show = show
        searchResultItemViewModel = SearchListItemViewModel(show: show, savedShowIds: savedShowIds)
    }
    
    var body: some View {
        NavigationLink(destination: SearchShowDetail(show: show, savedShowIds: searchViewModel.savedShows)) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w154\(show.poster_path)")) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Color.red
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 128, height: 192)
                .cornerRadius(6)
                .opacity(searchResultItemViewModel.isAlreadySaved ? 0.3 : 1.0)
                
                if searchResultItemViewModel.isAlreadySaved {
                    Image(systemName: "checkmark")
                        .font(Font.system(size: 16, weight: .bold))
                        .frame(width: 32, height: 32, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color("tintColor"))
                        .cornerRadius(8, antialiased: true)
                        .padding(4)
                }
            }
        }
    }
}
