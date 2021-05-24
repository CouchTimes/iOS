//
//  Season+CRUD.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation

extension Season {
    func updateSeasonFromResponse(_ seasonResponse: ShowSeasonResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.tmdbId = Int64(seasonResponse.id)
        
        self.title = seasonResponse.name
        self.number = Int64(seasonResponse.season_number)
        
        if let overview = seasonResponse.overview { self.overview = overview }
        if let episodes = seasonResponse.episodes { self.episodeCount = Int64(episodes.count) }
        
        if let airDate = seasonResponse.air_date {
            if !airDate.isEmpty {
                self.first_aired = dateFormatter.date(from: airDate)!
            }
        }
    }
}
