//
//  ShowInformation.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 07.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInformation: View {
    var description: String
    var airs: String
    var runtime: String
    var network: String
    var firstAired: String

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                SectionTitle(text: "Description")
                Text(description)
                    .lineLimit(nil)
                    .font(.body)
                    .foregroundColor(Color("textColor"))
            }
            Divider()
            VStack(alignment: .leading, spacing: 16) {
                InfoTextCell(label: "Airs", value: airs)
                InfoTextCell(label: "Runtime", value: runtime)
                InfoTextCell(label: "Network", value: network)
                InfoTextCell(label: "First Aired", value: firstAired)
            }
        }
    }
}
