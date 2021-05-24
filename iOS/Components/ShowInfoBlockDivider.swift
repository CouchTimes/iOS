//
//  ShowInfoBlockDivider.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 14.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfoBlockDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color("dividerColor"))
            .frame(width: 1, height: 32)
    }
}

struct ShowInfoBlockDivider_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfoBlockDivider()
    }
}
