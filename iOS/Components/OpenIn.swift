//
//  OpenIn.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 22.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct OpenIn: View {
    var label: String
    var url: URL

    var body: some View {
        Link(label, destination: url)
            .padding(8)
            .font(.callout)
            .foregroundColor(Color("tintColor"))
            .background(Color("backgroundColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color("tintColor"), lineWidth: 1)
            )
    }
}

struct OpenIn_Previews: PreviewProvider {
    static var previews: some View {
        OpenIn(label: "Test", url: URL(string: "https://fruechtl.me")!)
    }
}
