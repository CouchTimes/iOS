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
    var seasonCount: Int
    
    @State private var seasonSheet = false
    @State private var currentSeason: Season
    @State private var currentSeasonNumber = 0
    
    @EnvironmentObject var show: Show
    
    init(show: Show, seasonCount: Int) {
        self.seasonCount = seasonCount
        
        if let nextEpisode = show.nextEpisode, let seasonOfNextEpisode = nextEpisode.season {
            self._currentSeason = State(initialValue: seasonOfNextEpisode)
        } else {
            if let season = show.getSingleSeason(1) {
                self._currentSeason = State(initialValue: season)
            } else {
                self.seasonCount = 0
                self._currentSeason = State(initialValue: Season())
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if seasonCount > 1 {
                Button {
                    seasonSheet = true
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Text("Season \(currentSeason.number)")
                            .font(.callout)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.down")
                            .padding(.trailing, 4)
                    }
                    .foregroundColor(Color("textColor"))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            VStack {
                if (episodes != nil) {
                    LazyVStack(alignment: .leading) {
                        if episodes!.count > 0 {
                            ForEach(episodes!, id: \.self) { episode in
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
                                                .background (RoundedRectangle(cornerRadius: 8).fill(Color("tintColor")))
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
                                .padding(.vertical, 4)
                            }
                        } else {
                            HStack {
                                Spacer()
                                Text("No episodes announced yet")
                                Spacer()
                            }
                            .padding()
                            .cornerRadius(4)
                            .background(Color("cardBackground"))
                        }
                    }
                    .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
                }
            }
        }.fullScreenCover(isPresented: $seasonSheet) {
            ShowSeasonsPicker(seasons: orderedSeasons!, currentSeason: $currentSeason)
        }
    }
}

extension ShowSeasons {
    private var orderedSeasons: [Season]? {
        let seasons = show.getAllSeasons()
        return seasons.sorted(by: { $0.number > $1.number })
    }
    
    private var episodes: [Episode]? {
        if let episodes = currentSeason.episodes?.allObjects as? [Episode] {
            return episodes.sorted(by: { $0.episodeNumber < $1.episodeNumber })
        }
        
        return nil
    }
}
