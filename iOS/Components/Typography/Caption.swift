//
//  Caption.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct Caption: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(.footnote))
            .fontWeight(.medium)
            .foregroundColor(Color("captionColor"))
    }
}

struct Caption_Previews: PreviewProvider {
    static var previews: some View {
        Caption(text: "Caption Test")
    }
}
