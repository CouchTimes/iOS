//
//  ShowResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowResponse: Decodable {
    var backdrop_path: String?
    var first_air_date: String?
    var id: Int
    var name: String
    var original_language: String?
    var original_name: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var poster_data: Data?
    var vote_average: Float?
    var vote_count: Int?
}
