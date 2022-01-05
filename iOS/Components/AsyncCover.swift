//
//  AsyncCover.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.01.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct AsyncCover: View {
    var imageURL: URL
    
    init(imagePath: String, imageSize: AsyncCoverType) {
        switch imageSize {
        case .tiny:
            imageURL = URL(string: "https://image.tmdb.org/t/p/w92\(imagePath)")!
        case .small:
            imageURL = URL(string: "https://image.tmdb.org/t/p/w154\(imagePath)")!
        case .medium:
            imageURL = URL(string: "https://image.tmdb.org/t/p/w300\(imagePath)")!
        case .big:
            imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")!
        case .original:
            imageURL = URL(string: "https://image.tmdb.org/t/p/original\(imagePath)")!
        }
    }
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                Color.red
            } else {
                ProgressView()
            }
        }
    }
}

enum AsyncCoverType {
    case tiny
    case small
    case medium
    case big
    case original
}
