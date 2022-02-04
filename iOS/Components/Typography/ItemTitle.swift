//
//  ItemTitle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 17.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ItemTitle: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .bold))
            .multilineTextAlignment(.leading)
    }
}
