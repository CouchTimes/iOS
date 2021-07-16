//
//  Search.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 15.04.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct Search: View {
    @State private var showingSettings = false
    @ObservedObject var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            SearchTextField()
            if viewModel.searchMode {
                SearchResults()
            } else {
                ScrollView {
                    VStack {
                        SearchRecommendations()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showDetailsPresented) {
            SearchShowDetail(show: viewModel.selectedShow!, savedShowIds: viewModel.savedShows)
        }
        .onAppear {
            viewModel.getInitialData()
        }
        .environmentObject(viewModel)
    }
}

struct SearchSheet_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
