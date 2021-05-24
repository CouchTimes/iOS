//
//  ShowDetailsSeason.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowDetailSeason: Decodable {
    var air_date: String
    var episode_count: Int
    var id: Int
    var name: String
    var overview: String
    var poster_path: String
    var season_number: Int
}
