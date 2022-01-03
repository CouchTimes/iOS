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

    @State private var viewMode = 0
    @State private var showShareSheet = false
    @ObservedObject var searchItemViewModel: SearchListItemViewModel

    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        self.show = show
        searchItemViewModel = SearchListItemViewModel(show: show, savedShowIds: savedShowIds)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                ShowBlurredBackground(poster: Image(uiImage: showImage))
                VStack(spacing: 32) {
                    VStack(spacing: 32) {
                        ShowInformationHero(cover: showImage, title: show.name, year: show.wrappedYear, genres: genres, seasonCount: show.seasons.count)
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
                                Label("Added", systemImage: "checkmark")
                            } else {
                                Label("Add To Watchlist", systemImage: "plus")
                            }
                        }
                    }
                    .buttonStyle(AddToWatchlistButtonStyle())
                    .disabled(searchItemViewModel.isAlreadySaved)
                    .opacity(searchItemViewModel.isAlreadySaved ? 0.5 : 1.0)
                    
                    ShowInformation(description: show.wrappedOverview, airs: "Airs", runtime: show.wrappedRuntime, network: show.wrappedNetwork, firstAired: show.wrappedFirstAired)
                }
                .padding(.horizontal)
                .padding(.bottom, 112)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgroundColor"))
            .edgesIgnoringSafeArea(.all)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
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
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [URL(string: "https://www.themoviedb.org/tv/\(show.id)")!])
        }

    }
}

extension SearchShowDetail {
    private var showImage: UIImage {
        if let poster = show.poster_data {
            return UIImage(data: poster)!
        }

        return UIImage(named: "cover_placeholder")!
    }
    
    private var genres: [String]? {
        var transformedGenre = [String]()
        
        if let genres = show.genres {
            genres.forEach { genre in
                transformedGenre.append(genre.name)
            }
            
            return transformedGenre
        }
        
        return nil
    }
}
