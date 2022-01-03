//
//  SearchContent.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 23.12.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchContent: View {
    var query: String
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        VStack {
            if query.isEmpty {
                SearchRecommendations()
            } else {
                SearchResults(query: query)
            }
        }
    }
}
