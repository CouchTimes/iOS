//
//  SectionTitle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 17.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SectionTitle: View {
    var text: String

    var body: some View {
        Text(text.uppercased())
            .font(.system(.footnote))
            .kerning(0.72)
            .fontWeight(.bold)
            .foregroundColor(Color("captionColor"))
            .multilineTextAlignment(.leading)
    }
}

struct SectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitle(text: "Caption")
    }
}
