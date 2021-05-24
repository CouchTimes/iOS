//
//  ShowEpisodeResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 01.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowEpisodeResponse: Decodable {
    var air_date: String?
    var episode_number: Int
    var id: Int
    var name: String
    var overview: String?
    var season_number: Int
    var vote_average: Float?
    var vote_count: Int?
}
