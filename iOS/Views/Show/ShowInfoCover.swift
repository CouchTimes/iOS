//
//  ShowInfoCover.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfoCover: View {
    var poster: Image

    var body: some View {
        poster
            .resizable()
            .frame(width: 170, height: 256)
            .cornerRadius(6)
    }
}
