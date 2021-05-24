//
//  InfoTextCell.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 06.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct InfoTextCell: View {
    var label: String
    var value: String

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            SectionTitle(text: label)
            Spacer()
            SectionValue(text: value)
        }
    }
}

struct InfoTextCell_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextCell(label: "Label", value: "Value")
    }
}
