//
//  LibraryItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 29.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct LibraryItem: View {
    @State private var isPresented = false
    @Binding var show: Show
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            LibraryCover(cover: show.poster)
        }
        .sheet(isPresented: $isPresented) {
            ShowDetail(show: show)
        }
    }
}

//struct LibraryItem_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryItem()
//    }
//}
