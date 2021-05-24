//
//  SearchNoResult.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchNoResult: View {
    var body: some View {
        Group {
            Spacer()
            HStack {
                Text("No results :(")
            }
            Spacer()
        }
    }
}

struct SearchNoResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchNoResult()
    }
}
