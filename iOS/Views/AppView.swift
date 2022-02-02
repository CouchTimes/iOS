//
//  AppView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct AppView: View {
    let storageProvider: StorageProvider
    
    @State private var showSettings: Bool = false
    
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    @AppStorage("selectedAppearanceMode", store: UserDefaults(suiteName: "group.com.fruechtl.couchtimes")) var selectedAppearanceMode: Themes = .System
    
    var body: some View {
        TabView {
            Watchlist()
                .tabItem {
                    Image(systemName: "tv")
                        .imageScale(.large)
                    Text("Watchlist")
                }.tag(0)
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                    Text("Search")
                }.tag(1)
            Library()
                .tabItem {
                    Image(systemName: "square.3.stack.3d")
                        .imageScale(.large)
                    Text("Library")
                }.tag(2)
        }
        .accentColor(Color("titleColor"))
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
        .tint(Color("titleColor"))
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(storageProvider: StorageProvider())
    }
}
