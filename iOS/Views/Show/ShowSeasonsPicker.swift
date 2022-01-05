//
//  ShowSeasonsPicker.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.01.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowSeasonsPicker: View {
    var seasons: [Season]
    
    @Binding var currentSeason: Season
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Select a season")
                        .font(.title3)
                        .fontWeight(.bold)
                }.padding(.horizontal)
                Picker("Please choose a season", selection: $currentSeason) {
                    ForEach(seasons, id: \.self) { season in
                        Text("Season \(season.number)")
                    }
                }.pickerStyle(.wheel)
                Spacer()
            }.offset(y: 32)
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Select season")
            })
            .tint(Color("tintColor"))
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
    }
}
