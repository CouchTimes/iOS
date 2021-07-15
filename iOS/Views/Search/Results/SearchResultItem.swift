//
//  SearchResultItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 03.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchResultItem: View {
    var show: ShowDetailsResponse
    @State var isSavingAShow = false
    @ObservedObject var searchResultItemViewModel: SearchListItemViewModel

    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var searchViewModel: SearchViewModel

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        self.show = show
        searchResultItemViewModel = SearchListItemViewModel(show: show, savedShowIds: savedShowIds)
    }

    var body: some View {
        Button(action: {
            searchViewModel.selectedShow = show
            searchViewModel.showDetailsPresented.toggle()
        }) {
            HStack(alignment: .center, spacing: 16) {
                SearchResultItemPoster(poster: poster)
                VStack(alignment: .leading, spacing: 2.0) {
                    ItemTitle(text: title)
                        .lineLimit(2)
                    ItemCaption(text: show.wrappedYearString)
                }
                Spacer()
                Group {
                    if searchResultItemViewModel.isAlreadySaved {
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
                            self.searchViewModel.saveShow(show: searchResultItemViewModel.show) { result in
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
        searchResultItemViewModel.show.name
    }

    var poster: Image {
        if let poster = show.poster_data {
            return Image(uiImage: UIImage(data: poster)!)
        }

        return Image("cover_placeholder")
    }
}

// struct SearchResultItem_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultItem(show: ShowResponse())
//    }
// }
