//
//  ShowInformation.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 07.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInformation: View {
    var show: Show

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ShowDetailDescription(description: show.wrappedOverview)
            Divider()
            VStack(alignment: .leading, spacing: 20) {
                InfoTextCell(label: "Airs", value: show.wrappedAirs)
                InfoTextCell(label: "Runtime", value: show.wrappedRuntime)
                InfoTextCell(label: "Network", value: show.wrappedNetwork)
                InfoTextCell(label: "First Aired", value: show.wrappedFirstAirDate)
            }

            Divider()
            Group {
                VStack(alignment: .leading, spacing: 20) {
                    SectionTitle(text: "Open In")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 20) {
                            if show.homepage != nil {
                                if !show.homepage!.isEmpty {
                                    OpenIn(label: "Homepage", url: URL(string: show.homepage!)!)
                                }
                            }

                            if show.trailer != nil {
                                if !show.trailer!.isEmpty {
                                    OpenIn(label: "Trailer", url: URL(string: show.trailer!)!)
                                }
                            }

                            if show.imdbId != nil {
                                OpenIn(label: "IMDb", url: URL(string: "https://www.imdb.com/title/\(show.imdbId!)/")!)
                            }

                            OpenIn(label: "TMDB", url: URL(string: "https://www.themoviedb.org/tv/\(show.tmdbId)")!)
                        }
                    }
                }
            }
        }
        .padding(.top, 16)
    }
}

// struct ShowInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowInformation()
//    }
// }
