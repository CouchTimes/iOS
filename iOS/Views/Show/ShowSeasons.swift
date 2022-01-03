//
//  ShowSeasons.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 07.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI
import WidgetKit

struct ShowSeasons: View {
    @State private var currentSeason: Season?
    @State private var currentSeasonNumber = 0
    
    @EnvironmentObject var show: Show

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
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .padding(.trailing, 4)
                }
                .foregroundColor(Color("textColor"))
                .padding()
                .background(Color("cardBackground"))
                .cornerRadius(8)
            }
            VStack {
                if currentSeason != nil {
                    LazyVStack(alignment: .leading) {
                        ForEach(episodes, id: \.self) { episode in
                            HStack(alignment: .center, spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(episode.episodeNumber). \(episode.title)")
                                        .font(.headline)
                                        .foregroundColor(Color("titleColor"))
                                    ItemCaption(text: "\(episode.wrappedFirstAirDate)")
                                }
                                Spacer()
                                Button(action: {
                                    episode.toggleWatchedStatus()
                                    show.objectWillChange.send()
                                    WidgetCenter.shared.reloadAllTimelines()
                                }) {
                                    if episode.watched {
                                        Image(systemName: "checkmark")
                                            .frame(width: 32, height: 32, alignment: .center)
                                            .font(Font.system(size: 16, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .background (
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color("tintColor"))
                                            )
                                    } else {
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(Color("borderColor"), lineWidth: 2)
                                            .frame(width: 32, height: 32, alignment: .center)
                                            .opacity(episode.watchable ? 1.0 : 0.4)
                                    }
                                }
                                .frame(width: 44, height: 44, alignment: .center)
                                .disabled(episode.watchable ? false : true)
                            }
                        }
                    }
                    .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
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
    
    private var episodes: [Episode] {
        let episodes = currentSeason!.episodes!.allObjects as! [Episode]
        return episodes.sorted(by: { $0.episodeNumber < $1.episodeNumber })
    }
}
