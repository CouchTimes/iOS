//
//  VideoResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 01.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct VideoResponses: Decodable {
    var results: [VideoResponse]
}

struct VideoResponse: Decodable {
    var id: String
    var iso_639_1: String
    var iso_3166_1: String
    var key: String
    var name: String
    var site: String
    var size: Int
    var type: String
}
