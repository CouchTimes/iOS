//
//  SearchLoading.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 04.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchLoading: View {
    var body: some View {
        HStack(alignment: .center) {
            ProgressView("Searching for shows…")
                .padding()
                .background(Color("cardBackground"))
                .foregroundColor(Color("titleColor"))
                .cornerRadius(12)
        }
    }
}
