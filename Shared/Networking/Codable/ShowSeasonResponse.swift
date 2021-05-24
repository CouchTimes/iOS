//
//  ShowSeasonResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowSeasonResponse: Decodable {
    var air_date: String?
    var episodes: [ShowEpisodeResponse]?
    var id: Int
    var name: String
    var overview: String?
    var poster_path: String?
    var season_number: Int
}
