//
//  ShowInfoBlock.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfoBlock: View {
    var label: String
    var value: String

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(Font.system(size: 16, weight: .bold))
                .minimumScaleFactor(0.75)
                .lineLimit(1)
                .truncationMode(.tail)
                .lineSpacing(24)
            Text(label)
                .font(.footnote)
                .foregroundColor(Color("captionColor"))
        }.frame(maxWidth: .infinity)
    }
}

struct ShowInfoBlock_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfoBlock(label: "Label", value: "Value")
    }
}
