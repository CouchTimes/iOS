//
//  WatchlistCover.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 07.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct WatchlistCover: View {
    var cover: Data?

    var imageData: UIImage {
        if let data = cover {
            return UIImage(data: data)!
        }

        return UIImage(named: "cover_placeholder")!
    }

    var body: some View {
        Image(uiImage: imageData)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 96)
            .cornerRadius(8)
    }
}

struct WatchlistCover_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCover()
    }
}
