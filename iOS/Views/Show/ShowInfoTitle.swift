//
//  ShowInfoTitle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfoTitle: View {
    var title: String
    var subtitle: String?

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .truncationMode(.tail)

            if subtitle != nil {
                Text(subtitle!)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                    .foregroundColor(Color("captionColor"))
            }
        }
    }
}
