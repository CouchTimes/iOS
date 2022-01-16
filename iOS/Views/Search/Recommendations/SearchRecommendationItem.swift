//
//  SearchRecommendationItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 27.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendationItem: View {
    @ObservedObject var searchItemViewModel: SearchItemViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        searchItemViewModel = SearchItemViewModel(show: show, savedShowIds: savedShowIds)
    }
    
    var body: some View {
        NavigationLink(destination: SearchShowDetail(show: searchItemViewModel.show, savedShowIds: searchViewModel.savedShows)) {
            ZStack(alignment: .topTrailing) {
                AsyncCover(imagePath: searchItemViewModel.show.poster_path, imageSize: .small)
                    .frame(width: 128, height: 192)
                    .cornerRadius(6)
                    .opacity(searchItemViewModel.isAlreadySaved ? 0.3 : 1.0)
                
                if searchItemViewModel.isAlreadySaved {
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
