//
//  ShowSeasons.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 07.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowSeasons: View {
    var show: Show
    @State private var currentSeason: Season?
    @State private var currentSeasonNumber = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Menu {
                ForEach(orderedSeasons, id: \.id) { season in
                    Button("Season \(season.number)", action: {
                        let number = Int(season.number)
                        getCurrentSeason(number)
                    })
                }
            } label: {
                HStack(alignment: .center, spacing: 8) {
                    Text("Season \(currentSeasonNumber)")
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(Color("textColor"))
            }
            VStack {
                if currentSeason != nil {
                    ShowEpisodesList(season: currentSeason!)
                }
            }
        }.onAppear {
            self.getCurrentSeason(1)
        }
    }
}

extension ShowSeasons {
    private func getCurrentSeason(_ seasonNumber: Int) {
        self.currentSeasonNumber = seasonNumber
        self.currentSeason = show.getSingleSeason(seasonNumber)
    }
    
    private var orderedSeasons: [Season] {
        let seasons = show.getAllSeasons()
        return seasons!.sorted(by: { $0.number > $1.number })
    }
}
