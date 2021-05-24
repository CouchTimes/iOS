//
//  ShowDetail.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowDetail: View {
    private var didManagedObjectContextSave = NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    
    @State private var showDetailMode = 0
    @State private var selectedSeason: Season?
    @State private var showingSeasonDetails = false
    
    @StateObject private var viewModel: ShowViewModel

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    init(showId: Int) {
        _viewModel = StateObject(wrappedValue: ShowViewModel(showId: showId))
    }

    var body: some View {
        if viewModel.show != nil {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ZStack(alignment: .topLeading) {
                        ShowBlurredBackground(poster: Image(uiImage: showImage))
                        VStack(alignment: .center, spacing: 0) {
                            VStack {
                                SheetDragHandle()
                                    .padding(.top, 16)
                                ShowToolbar(presentationMode: presentationMode, showViewModel: Binding.constant(viewModel))
                                ShowInfoBox(poster: Image(uiImage: showImage),
                                            title: viewModel.show!.title,
                                            genre: viewModel.show!.wrappedGenre,
                                            rating: viewModel.show!.wrappedRating,
                                            status: viewModel.show!.wrappedStatus
                                ).padding(.horizontal)
                                

                                Picker(selection: $showDetailMode, label: Text("What is your favorite color?")) {
                                    Image(systemName: "list.bullet")
                                        .tag(0)
                                    Image(systemName: "info.circle")
                                        .tag(1)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                            }.background(colorScheme == .dark ?
                                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.16), Color.black.opacity(0.32), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom) :
                                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.16), Color.white.opacity(0.32), Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom))

                            Group {
                                if showDetailMode == 0 {
                                    ShowSeasonsList(seasons: Binding.constant(viewModel.seasons),
                                                    showingSeasonDetails: self.$showingSeasonDetails,
                                                    selectedSeason: self.$selectedSeason)
                                        .sheet(item: self.$selectedSeason) { season in
                                            ShowSeason(show: viewModel.show!, season: season)
                                        }
                                }

                                if showDetailMode == 1 {
                                    ShowInformation(show: viewModel.show!)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 48)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgroundColor"))
            .edgesIgnoringSafeArea(.all)
            .onReceive(self.didManagedObjectContextSave) { _ in
                viewModel.fetchShowById(Int(viewModel.show!.tmdbId))
                viewModel.showWatched()
            }
        }
    }
}

extension ShowDetail {
    var showImage: UIImage {
        if let poster = viewModel.show!.poster {
            return UIImage(data: poster)!
        }

        return UIImage(named: "cover_placeholder")!
    }
}

// struct ShowDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowDetail(showId: 1)
//    }
// }
