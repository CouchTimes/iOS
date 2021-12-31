//
//  ShowDetailDescription.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 15.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowDetailDescription: View {
    var description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitle(text: "Description")
            Text(description)
                .lineLimit(nil)
                .font(.body)
                .foregroundColor(Color("textColor"))
        }
    }
}
