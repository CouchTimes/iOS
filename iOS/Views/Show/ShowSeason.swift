//
//  ShowSeason.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowSeason: View {
    private let moc = StorageProvider.shared.persistentContainer.viewContext

    var show: Show
    var season: Season

    @State private var refreshingID = UUID()

    @StateObject private var viewModel: SeasonDetailViewViewModel

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext

    init(show: Show, season: Season) {
        self.show = show
        self.season = season
        _viewModel = StateObject(wrappedValue: SeasonDetailViewViewModel(show: show, season: season))
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    Rectangle()
                        .fill(Color("titleColor"))
                        .frame(width: 48, height: 4)
                        .cornerRadius(4)
                        .padding(.top, 16)

                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .center) {
                            Text("Season \(viewModel.season.number)")
                                .font(Font.system(size: 32, weight: .bold))
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Spacer()
                            Button(action: {
                                self.viewModel.markAllEpisodesAsWatched(season: self.viewModel.season)
                            }) {
                                Group {
                                    if !self.viewModel.allEpisodesWatched {
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(Color("borderColor"), lineWidth: 2)
                                            .frame(width: 32, height: 32, alignment: .center)
                                    }
                                }
                            }
                            .frame(width: 32, height: 32, alignment: .center)
                            .disabled(self.viewModel.allEpisodesWatched ? true : false)
                            .buttonStyle(EpisodeButtonStyle())
                        }
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.episodes, id: \.self) { episode in
                                Button(action: {
                                    self.viewModel.toggleWatchedStatusOfEpisode(episode: episode)
                                }) {
                                    HStack(alignment: .center, spacing: 20) {
                                        VStack(alignment: .leading, spacing: 10) {
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
                            .id(refreshingID)
                        }
                    }.padding(.horizontal)
                }
            }
        }
        .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
        .onAppear {
            self.viewModel.getAllEpisodes()
            self.viewModel.isThisSeasonWatched()
        }
    }
}

// struct ShowSeason_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowSeason(season: )
//    }
// }

struct EpisodeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
//            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
    }
}
