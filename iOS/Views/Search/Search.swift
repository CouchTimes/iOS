//
//  Search.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 15.04.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct Search: View {
    @State private var query: String = ""
    @State private var showingSettings = false
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            SearchContent(query: query)
            .navigationTitle("Search")
        }
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for new shows")
        .onSubmit(of: .search) {
            self.viewModel.isLoading = true
            self.viewModel.searchShowByName(query)
        }
        .onAppear {
            viewModel.getInitialData()
        }
        .environmentObject(viewModel)
    }
}
