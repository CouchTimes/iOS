//
//  LibraryItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 29.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct LibraryItem: View {
    @Binding var show: Show
    
    var body: some View {
        Image(uiImage: imageData)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
    }
}

extension LibraryItem {
    var imageData: UIImage {
        if let data = show.poster {
            return UIImage(data: data)!
        }

        return UIImage(named: "cover_placeholder")!
    }
}
