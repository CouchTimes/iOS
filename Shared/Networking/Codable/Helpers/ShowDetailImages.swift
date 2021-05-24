//
//  ShowDetailsImages.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowDetailImages: Decodable {
    var backdrops: [ShowDetailImageSource]
    var posters: [ShowDetailImageSource]
}

struct ShowDetailImageSource: Decodable {
    var aspect_ratio: Float
    var file_path: String
    var height: Int
//    var iso_639_1: null
    var vote_average: Double
    var vote_count: Int
    var width: Int
}
