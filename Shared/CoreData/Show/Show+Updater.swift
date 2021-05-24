//
//  Show+Updater.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 03.11.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation

extension Show {
    
    // MARK: Show CRUD
    
    func updateShowFromResponse(_ showResponse: ShowDetailsResponse, seasons: [ShowSeasonResponse]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.tmdbId = Int64(showResponse.id)
        self.title = showResponse.name
            
        self.overview = showResponse.overview
        self.status = showResponse.status
        self.homepage = showResponse.homepage
        if let rating = showResponse.vote_average { self.rating = rating }
        
        if let runtime = showResponse.episode_run_time, let firstRuntime = runtime.first {
            self.runtime = Int64(firstRuntime)
        }
        
        self.genres = showResponse.genreAsStringArray
        
        if let airDate = showResponse.first_air_date {
            if !airDate.isEmpty {
                let firstAiredDate = dateFormatter.date(from: airDate)!
                self.firstAirDate = firstAiredDate
                
                dateFormatter.dateFormat = "yyyy"
                let year = dateFormatter.string(from: firstAiredDate)
                
                self.year = Int64(year)!
            }
        }
        
        if let networks = showResponse.networks, let network = networks.first {
            self.network = network.name
        }
        
        if let videos = showResponse.videos, let firstResult = videos.results.first {
            self.trailer = "https://www.youtube.com/watch?v=\(firstResult.key)"
        }
        
        self.updateShowImage(showResponse: showResponse)
        self.updateShowSeasons(seasons)
        
        self.updatedAt = Date()
    }
    
    // MARK: Handle show seasons
    
    private func updateShowSeasons(_ seasonsResponse: [ShowSeasonResponse]) {
        // Get all seaons from the server response that are not season 0
        let seasonsFromResponse = seasonsResponse.filter { $0.season_number > 0 }
        
        guard let seasons = self.seasons else {
            print("Couldn't unwrap the 'seasons' property from the show object.")
            return
        }
        
        // If the count of seasons inside CoreData is bigger than 0
        if seasons.count == 0 {
            // Loop through all seaons from the response
            seasonsResponse.forEach { season in
                createSeason(season)
            }
        
        // If the count of "filteredSeaonResponse" is bigger OR equal the count of seasons inside CoreData
        } else if (seasonsFromResponse.count >= seasons.count) {
            updateSeasons(seasonsResponse)
        }
    }
    
    private func createSeason(_ season: ShowSeasonResponse) {
        guard let managedObjectContext = self.managedObjectContext else {
            print("Couldn't unwrap the managedObjectContext (CoreData) from the show object.")
            return
        }
        
        // Move forward if the season number is greater than 0
        if season.season_number > 0 {
            let seasonNumber = season.season_number
                
            // Create a new season entity and update it with all the data
            let coreDataSeason = Season(context: managedObjectContext)
            coreDataSeason.updateSeasonFromResponse(season)
                
            // Loop through all episode from the season response
            if let episodes = season.episodes {
                episodes.forEach { episode in
                    // Check if the season number from the episode matches the season we are currently in
                    if episode.season_number == seasonNumber {
                        // Create a new episode entity and update it with all the data
                        let coreDataEpisode = Episode(context: managedObjectContext)
                        coreDataEpisode.updateEpisodeFromResponse(episode, coreDataShow: self)
                            
                        // Add episodes to the season
                        coreDataSeason.addToEpisodes(coreDataEpisode)
                    }
                }
            }

            self.addToSeasons(coreDataSeason)
        }
    }
    
    private func updateSeasons(_ seasonsResponse: [ShowSeasonResponse]) {
        // Unwrap all optional seasons as an NSSet
        if let seasons = self.seasons?.allObjects as? [Season]  {
            if seasonsResponse.count == seasons.count {
                seasonsResponse.forEach { seasonResponse in
                    if seasonResponse.season_number > 0 {
                        let seasonResponseSeasonNumber = seasonResponse.season_number
                        
                        // Get the season we iterate on (seasonsResponse.forEach {...})
                        if let singleSeason = seasons.filter({ $0.number == seasonResponseSeasonNumber}).first {
                            // Update the season with all the data
                            singleSeason.updateSeasonFromResponse(seasonResponse)
                            self.updateEpisodes(season: singleSeason, seasonResponse: seasonResponse)
                            
                            print("Successfully updated '\(self.title)', season \(singleSeason.number)")
                        }
                    }
                }
            } else {
                seasonsResponse.forEach { response in
                    if response.season_number > 0 {
                        let seasonResponseSeasonNumber = response.season_number
                        
                        // Search and get the season we iterate on (seasonsResponse.forEach {...})
                        if let singleSeason = seasons.filter({ $0.number == seasonResponseSeasonNumber}).first {
                            singleSeason.updateSeasonFromResponse(response)
                            self.updateEpisodes(season: singleSeason, seasonResponse: response)
                            
                            print("Successfully updated \(singleSeason.title), season \(singleSeason.number)")
                        } else {
                            createSeason(response)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Handle everything episode-related for shows
    
    private func updateEpisodes(season: Season, seasonResponse: ShowSeasonResponse) {
        // Unwrap all optional episodes as an NSSet
        guard let episodes = season.episodes?.allObjects as? [Episode] else {
            print("Couldn't unwrap and cast the 'episodes' property from the show object.")
            return
        }
        
        // Loop through all CoreData episodes
        episodes.forEach { episode in
            // Unwrap all episodes from ShowSeasonResponse
            guard let episodesResponse = seasonResponse.episodes else { return }
            
            // Unwrap matching episode based on the episode number of the CoreData entry and the ShowSeasonResponse entry
            if let episodeResponse = episodesResponse.filter({ $0.episode_number == episode.episodeNumber }).first {
                episode.updateEpisodeFromResponse(episodeResponse, coreDataShow: self)
            } else {
                print("DAHAHAHAHAHA SAD")
            }
        }
    }
    
    
    
    // MARK: Handle everything image-related for shows
    
    func updateShowImage(showResponse: ShowDetailsResponse) {
        guard let images = self.showImages else {
            print("Couldn't unwrap the 'showImages' property from the show object.")
            return
        }
        
        if images.count == 0 {
            guard let managedObjectContext = self.managedObjectContext else {
                print("Couldn't unwrap the managedObjectContext (CoreData) from the show object.")
                return
            }
            
            if let path = showResponse.poster_path, let data = showResponse.poster_data {
                let coreDataShowImage = ShowImage(context: managedObjectContext)
                coreDataShowImage.updateShowImageFromResponse(path: path, data: data)
                self.addToShowImages(coreDataShowImage)
            }
        }
    }
}
