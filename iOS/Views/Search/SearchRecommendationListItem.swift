//
//  SearchRecommendationListItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 16.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchRecommendationListItem: View {
    var title: String
    var type: SearchRecommendationType

    var body: some View {
        NavigationLink(destination: SearchRecommendationDetailsView(title: title, type: type)) {
            HStack(alignment: .center) {
                ItemTitle(text: title)
                    .foregroundColor(recommendationForgroundColor)
                    .lineLimit(2)
                    .truncationMode(.tail)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(Font.system(size: 14, weight: .semibold))
                    .foregroundColor(recommendationForgroundColor)
                    .opacity(0.5)
            }
            .padding(.horizontal)
            .frame(height: 72)
            .background(recommendationBackgroundColor)
            .cornerRadius(4)
        }
    }
}

extension SearchRecommendationListItem {
    var recommendationForgroundColor: Color {
        switch type {
        case .popular:
            return Color("titleColor")
        case .topRated:
            return Color("titleColor")
        case .netflix:
            return Color.white
        case .apple:
            return Color("backgroundColor")
        case .hbo:
            return Color.white
        case .disney:
            return Color.white
        case .amazon:
            return Color.white
        case .hulu:
            return Color.black
        case .showtime:
            return Color.white
        case .syfy:
            return Color("titleColor")
        }
    }
    
    var recommendationBackgroundColor: Color {
        switch type {
        case .popular:
            return Color("cardBackground")
        case .topRated:
            return Color("cardBackground")
        case .netflix:
            return Color("networkNetflix")
        case .apple:
            return Color("networkAppleTV+")
        case .hbo:
            return Color("networkHBO")
        case .disney:
            return Color("networkDisney+")
        case .amazon:
            return Color("networkAmazon")
        case .hulu:
            return Color("networkHulu")
        case .showtime:
            return Color("networkShowtime")
        case .syfy:
            return Color("networkSyfy")
        }
    }
}
