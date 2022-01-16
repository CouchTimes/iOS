//
//  SearchShowDetail.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchShowDetail: View {
    @State private var showShareSheet = false
    @ObservedObject var searchItemViewModel: SearchItemViewModel
    
    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        searchItemViewModel = SearchItemViewModel(show: show, savedShowIds: savedShowIds)
        searchItemViewModel.getFullShowData()
    }

    var body: some View {
        Self._printChanges()
        
        return ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                ShowBlurredBackground(poster: Image(uiImage: showImage), posterColor: showImageColor)
                VStack(spacing: 32) {
                    VStack(spacing: 32) {
                        ShowInformationHero(asyncCover: searchItemViewModel.show.poster_path, title: searchItemViewModel.show.name, year: searchItemViewModel.show.wrappedYear, genres: genres, seasonCount: searchItemViewModel.show.seasons.count)
                    }
                    
                    Button(action: {
                        self.searchItemViewModel.saveShow() { result in
                            switch result {
                            case .success(_):
                                print("Wow")
                            case let .failure(error):
                                print(error)
                            }
                        }
                    }) {
                        if searchItemViewModel.isSavingShow {
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
                    
                    ShowInformation(description: searchItemViewModel.show.wrappedOverview, airs: "Airs", runtime: searchItemViewModel.show.wrappedRuntime, network: searchItemViewModel.show.wrappedNetwork, firstAired: searchItemViewModel.show.wrappedFirstAired)
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
            ShareSheet(activityItems: [URL(string: "https://www.themoviedb.org/tv/\(searchItemViewModel.show.id)")!])
        }
    }
}

extension SearchShowDetail {
    private var showImage: UIImage {
        if let poster = searchItemViewModel.show.poster_data {
            return UIImage(data: poster)!
        }

        return UIImage(named: "cover_placeholder")!
    }
    
    private var showImageColor: Color {
        if let poster = searchItemViewModel.show.poster_data, let color = UIImage(data: poster)!.averageColor {
            return Color(color)
        }
        
        return Color(.clear)
    }
    
    private var genres: [String]? {
        var transformedGenre = [String]()
        
        if let genres = searchItemViewModel.show.genres {
            genres.forEach { genre in
                transformedGenre.append(genre.name)
            }
            
            return transformedGenre
        }
        
        return nil
    }
}
