//
//  SearchResultItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 03.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchResultItem: View {
    @State var isSavingAShow = false
    @ObservedObject var searchItemViewModel: SearchItemViewModel

    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        searchItemViewModel = SearchItemViewModel(show: show, savedShowIds: savedShowIds)
    }

    var body: some View {
        NavigationLink(destination: SearchShowDetail(show: searchItemViewModel.show, savedShowIds: searchViewModel.savedShows)) {
            HStack(alignment: .center, spacing: 20) {
                AsyncCover(imagePath: searchItemViewModel.show.poster_path, imageSize: .tiny)
                    .frame(width: 48, height: 72)
                    .cornerRadius(6)
                VStack(alignment: .leading, spacing: 2.0) {
                    ItemTitle(text: title)
                        .foregroundColor(Color("titleColor"))
                        .lineLimit(2)
                    ItemCaption(text: searchItemViewModel.show.wrappedYearString)
                }
                Spacer()
                Group {
                    if searchItemViewModel.isAlreadySaved {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 16, weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(width: 32, height: 32, alignment: .center)
                            .background (
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("tintColor"))
                            )
                            .opacity(0.3)
                    } else {
                        Button(action: {
                            isSavingAShow = true
                            self.searchItemViewModel.saveShow() { result in
                                switch result {
                                case .success(_):
                                    isSavingAShow = false
                                case let .failure(error):
                                    print(error)
                                }
                            }
                        }) {
                            if isSavingAShow {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                                    .foregroundColor(Color.white)
                                    .frame(width: 32, height: 32, alignment: .center)
                            } else {
                                Image(systemName: "plus")
                                    .font(Font.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("titleColor"))
                                    .frame(width: 32, height: 32, alignment: .center)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(Color("borderColor"), lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
}

extension SearchResultItem {
    var title: String {
        searchItemViewModel.show.name
    }

    var poster: Image {
        if let poster = searchItemViewModel.show.poster_data {
            return Image(uiImage: UIImage(data: poster)!)
        }

        return Image("cover_placeholder")
    }
}
