//
//  LibraryCover.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 24.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct LibraryCover: View {
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
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
    }
}

struct LibraryCover_Previews: PreviewProvider {
    static var previews: some View {
        LibraryCover()
    }
}
