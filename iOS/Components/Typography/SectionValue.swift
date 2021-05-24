//
//  SectionTitle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 17.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SectionValue: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(.body))
            .foregroundColor(Color("titleColor"))
            .multilineTextAlignment(.trailing)
    }
}

struct SectionValue_Previews: PreviewProvider {
    static var previews: some View {
        SectionValue(text: "Caption")
    }
}
