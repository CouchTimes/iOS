//
//  Episode+CRUD.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation

extension Episode {
    func updateEpisodeFromResponse(_ episodeResponse: ShowEpisodeResponse, coreDataShow: Show) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.tmdbId = Int64(episodeResponse.id)
        
        self.title = episodeResponse.name
        if let overview = episodeResponse.overview { self.overview = overview }
        
        self.seasonNumber = Int16(episodeResponse.season_number)
        self.episodeNumber = Int16(episodeResponse.episode_number)
        
        if let airDate = episodeResponse.air_date {
            if !airDate.isEmpty {
                self.first_aired = dateFormatter.date(from: airDate)! }
        }
        if let rating = episodeResponse.vote_average { self.rating = rating }
        
        self.show = coreDataShow
    }
}
