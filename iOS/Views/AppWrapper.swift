//
//  AppWrapper.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 17.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct AppWrapper: View {
    var body: some View {
        TabView {
            Watchlist()
                .tabItem {
                    Image(systemName: "tv")
                        .imageScale(.large)
                    Text("Watchlist")
                }
                .tag(0)
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                    Text("Search")
                }
                .tag(1)
        }
        .accentColor(Color("textDefault"))
    }
}

struct AppWrapper_Previews: PreviewProvider {
    static var previews: some View {
        AppWrapper()
    }
}
