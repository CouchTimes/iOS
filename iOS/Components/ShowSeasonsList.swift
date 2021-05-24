//
//  ShowSeasonsList.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 07.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowSeasonsList: View {
    @Binding var seasons: [Season]
    @Binding var showingSeasonDetails: Bool
    @Binding var selectedSeason: Season?

    var body: some View {
        VStack {
            ForEach(seasons, id: \.self) { season in
                Button(action: {
                    self.selectedSeason = season
                    self.showingSeasonDetails.toggle()
                }) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            ItemTitle(text: "Season \(season.number)")
                            ItemCaption(text: "\(season.episodesToGo) episodes left")
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("captionColor"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color("backgroundColor"))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }.background(Color("backgroundColor"))
    }
}

// struct ShowSeasonsList_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowSeasonsList()
//    }
// }
