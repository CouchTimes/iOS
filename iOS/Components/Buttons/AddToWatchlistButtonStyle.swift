//
//  AddToWatchlistButtonStyle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct AddToWatchlistButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .background(Color("tintColor"))
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .font(Font.system(size: 18, weight: .bold))
    }
}

struct AddToWatchlistButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Add To Watchlist")
        }.buttonStyle(AddToWatchlistButtonStyle())
    }
}
