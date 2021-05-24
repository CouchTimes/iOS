//
//  SearchShowDetail.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchShowDetail: View {
    var show: ShowDetailsResponse

    @State private var showShareSheet = false
    @ObservedObject var searchItemViewModel: SearchListItemViewModel

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        self.show = show
        searchItemViewModel = SearchListItemViewModel(show: show, savedShowIds: savedShowIds)
    }

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                ShowBlurredBackground(poster: poster)
                VStack {
                    Group {
                        SheetDragHandle()
                        Group {
                            HStack(alignment: .center) {
                                Button(action: {
                                    searchViewModel.showDetailsPresented = false
                                }) {
                                    Image(systemName: "chevron.down")
                                        .font(Font.system(size: 20, weight: .bold))
                                        .frame(minWidth: 96.0, minHeight: 48.0, alignment: .leading)
                                }
                                Spacer()
                                Menu {
                                    Section {
                                        Button(action: {
                                            self.showShareSheet = true
                                        }) {
                                            Label("Share", systemImage: "square.and.arrow.up")
                                        }
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .font(Font.system(size: 20, weight: .bold))
                                        .frame(minWidth: 96.0, minHeight: 48.0, alignment: .trailing)
                                }
                            }
                            .padding(.horizontal)
                            .foregroundColor(Color("titleColor"))
                        }
                        ShowInfoBox(poster: poster, title: show.name, subtitle: show.wrappedYearString, genre: show.wrappedGenre, rating: show.wrappedRatingString, status: show.wrappedStatus)
                    }

                    Button(action: {
                        self.searchViewModel.saveShow(show: searchItemViewModel.show) { result in
                            switch result {
                            case .success(_):
                                print("Wow")
                            case let .failure(error):
                                print(error)
                            }
                        }
                    }) {
                        if searchViewModel.isSavingShow {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        } else {
                            if searchItemViewModel.isAlreadySaved {
                                HStack(alignment: .center, spacing: 4) {
                                    Image(systemName: "checkmark")
                                    Text("Added")
                                }
                            } else {
                                Text("Add To Watchlist")
                            }
                        }
                    }
                    .buttonStyle(AddToWatchlistButtonStyle())
                    .disabled(searchItemViewModel.isAlreadySaved)
                    .opacity(searchItemViewModel.isAlreadySaved ? 0.5 : 1.0)

                    VStack(alignment: .leading, spacing: 16) {
                        ShowDetailDescription(description: show.overview!)
                        Divider()
                        VStack(alignment: .leading, spacing: 16) {
                            InfoTextCell(label: "Runtime", value: show.wrappedRuntime)
                            InfoTextCell(label: "Network", value: show.wrappedNetwork)
                            InfoTextCell(label: "First Aired", value: show.wrappedFirstAired)
                        }
                        Divider()
                        Group {
                            VStack(alignment: .leading, spacing: 16) {
                                SectionTitle(text: "Open In")
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .center, spacing: 16) {
                                        if show.homepage != nil {
                                            if !show.homepage!.isEmpty {
                                                OpenIn(label: "Homepage", url: URL(string: show.homepage!)!)
                                            }
                                        }

                                        if show.wrappedTrailer != nil {
                                            if !show.wrappedTrailer!.isEmpty {
                                                OpenIn(label: "Trailer", url: URL(string: show.wrappedTrailer!)!)
                                            }
                                        }

                                        OpenIn(label: "TMDb", url: URL(string: "https://www.themoviedb.org/tv/\(show.id)")!)
                                    }
                                }
                            }
                        }
                    }.padding()
                }
                .padding(.top, 16)
                .padding(.bottom, 48)
            }
            .navigationBarTitle(show.name)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [URL(string: "https://www.themoviedb.org/tv/\(show.id)")!])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundColor"))
        .edgesIgnoringSafeArea(.all)
    }
}

extension SearchShowDetail {
    var poster: Image {
        if let poster = show.poster_data {
            return Image(uiImage: UIImage(data: poster)!)
        }

        return Image("cover_placeholder")
    }
}
