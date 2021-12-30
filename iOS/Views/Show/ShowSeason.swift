//
//  ShowSeason.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowSeason: View {
    var season: Season
    
    var episodes: [Episode] {
        let episodes = season.episodes!.allObjects as! [Episode]
        return episodes.sorted(by: { $0.episodeNumber < $1.episodeNumber })
    }

    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(episodes, id: \.self) { episode in
                Button(action: {
//                    self.viewModel.toggleWatchedStatusOfEpisode(episode: episode)
                }) {
                    HStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(episode.episodeNumber). \(episode.title)")
                                .font(.headline)
                                .foregroundColor(Color("titleColor"))
                            ItemCaption(text: "\(episode.wrappedFirstAirDate)")
                        }
                        Spacer()
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
                }
                .disabled(episode.watchable ? false : true)
                .buttonStyle(EpisodeButtonStyle())
            }
        }
        .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
        .onAppear {
        }
    }
}

struct EpisodeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
    }
}
