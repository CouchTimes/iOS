//
//  OnboardingView.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 31.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (alignment: .leading, spacing: 108) {
            VStack(alignment: .leading) {
                Text("Welcome to").font(.system(size: 48)).fontWeight(.heavy).foregroundColor(.primary)
                Text("CouchTimes").font(.system(size: 48)).fontWeight(.heavy).foregroundColor(Color("tintColor"))
            }.padding(.top, 72).padding(.horizontal, 16)
            
            VStack (alignment: .leading, spacing: 32) {
                OnboardingItem(title: "Watchlist and Library", text: "Decide what show you want to track right now and what show you want to achieve in your library.", iconName: "list.star")
                OnboardingItem(title: "Beautiful Interface", text: "Simple and beautiful interface. Easy to use with a focus on your shows.", iconName: "sparkles")
                OnboardingItem(title: "iCloud Sync", text: "All your shows and progress are automatically backup up with iCloud.", iconName: "cloud")
            }.padding(.horizontal, 16)
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "showOnboarding")
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Welcome").foregroundColor(.white).bold()
            }
            .buttonStyle(AddToWatchlistButtonStyle())
        }
        .padding(.bottom, 24)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
