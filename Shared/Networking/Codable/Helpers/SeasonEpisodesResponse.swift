//
//  SeasonEpisodesResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct SeasonEpisodesResponse: Decodable {
    var air_date: String
    var episode_number: Int
    var crew: [EpisodeCrew]
    var id: Int
    var name: String
    var overview: String
    var production_code: String
    var season_number: Int
    var still_path: String
    var vote_average: Float
    var vote_count: Int
}
