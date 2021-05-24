//
//  SheetDragHandle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 03.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SheetDragHandle: View {
    var body: some View {
        Rectangle()
            .fill(Color("titleColor"))
            .frame(width: 48, height: 4)
            .cornerRadius(4)
    }
}

struct SheetDragHandle_Previews: PreviewProvider {
    static var previews: some View {
        SheetDragHandle()
    }
}
