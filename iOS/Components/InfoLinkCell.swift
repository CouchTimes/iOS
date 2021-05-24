//
//  InfoLinkCell.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 06.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct InfoLinkCell: View {
    var label: String
    var value: String
    var destination: String

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            SectionTitle(text: label)
            Spacer()
            Link(value, destination: URL(string: destination)!)
        }
    }
}

struct InfoLinkCell_Previews: PreviewProvider {
    static var previews: some View {
        InfoLinkCell(label: "Label", value: "Value", destination: "https://www.hackingwithswift.com/quick-start/swiftui")
    }
}
