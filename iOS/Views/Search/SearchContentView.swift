//
//  SearchContentView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 16.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchContentView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        VStack {
//            SearchTextField()
            if searchViewModel.isLoading {
                VStack {
                    Spacer()
                    SearchLoading()
                    Spacer()
                }
            } else {
                if searchViewModel.searchedShows.count > 0 || searchViewModel.searchMode {
                    SearchResults()
                } else {
                    ScrollView {
                        VStack {
                            SearchRecommendations()
                        }
                    }
                }
            }
        }
    }
}

struct SearchContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContentView()
    }
}
