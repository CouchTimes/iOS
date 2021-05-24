//
//  ItemCaption.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 17.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ItemCaption: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(.footnote))
            .fontWeight(.medium)
            .foregroundColor(Color("captionColor"))
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            .truncationMode(.tail)
    }
}

struct ItemCaption_Previews: PreviewProvider {
    static var previews: some View {
        ItemCaption(text: "This is a caption")
    }
}
