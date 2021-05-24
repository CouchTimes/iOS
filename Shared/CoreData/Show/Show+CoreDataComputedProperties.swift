//
//  Show+CoreDataComputedProperties.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 26.09.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation

// MARK: Direct Access

extension Show {
    public var wrappedStatus: String {
        var s = "Unknown"
        
        if status == "returning series" {
            s = "returning"
        } else if status == "ended" {
            s = "ended"
        }
        
        return s.capitalized
    }
    
    public var wrappedGenre: String {
        guard let g = genres else { return "No genre set" }
        guard let genre = g.first else { return "No genre set" }
        
        return genre.capitalized
    }
    
    public var wrappedRating: String {
        return String(format: "%.1f", rating)
    }
    
    public var wrappedOverview: String {
        overview ?? "Unknown overview"
    }
    
    public var wrappedAirs: String {
        if let day = airsDay, let time = airsTime, let timezone = airsTimezone {
            return "\(day), \(time), \(timezone)"
        } else {
            return "Unknown air time"
        }
    }
    
    public var wrappedRuntime: String {
        "\(runtime) mins"
    }
    
    public var wrappedNetwork: String {
        network ?? "Unknown network"
    }
    
    public var wrappedFirstAirDate: String {
        if let date = firstAirDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy"
            
            return formatter.string(from: date)
        }
        return "Unknown first air date"
    }
    
    public var wrappedSeasons: [Season]? {
        if let seasons = self.seasons {
            return (seasons.allObjects as! [Season])
        }
        
        return nil
    }
    
    public var wrappedEpisodes: [Episode]? {
        if let episodes = self.episodes {
            return (episodes.allObjects as! [Episode])
        }
        
        return nil
    }
}

// MARK: Episode Count & Next Episode

extension Show {
    public var episodeCount: Int {
        guard let episodes = self.episodes?.allObjects as? [Episode] else { return 0 }
        let watchableEpisodes = episodes.filter { $0.watchable == true }
        var episodesToGo = watchableEpisodes.count
        
        watchableEpisodes.forEach { episode in
            if episode.watched {
                episodesToGo -= 1
            }
        }
        
        return episodesToGo
    }
    
    public var nextEpisode: Episode? {
        var nextEpisode: Episode?
        
        guard let episodes = self.episodes?.allObjects as? [Episode] else { return nil }
        let sortedEpisodes = episodes.sorted { ($0.seasonNumber, $0.episodeNumber) < ($1.seasonNumber, $1.episodeNumber) }
            
        if sortedEpisodes.count == 0 {
            return nil
        }
            
        for episode in sortedEpisodes {
            if !episode.watched && episode.watchable {
                nextEpisode = episode
                break
            }
        }
        
        return nextEpisode
    }
    
    public var nextEpisodeToWatch: String {
        if let episode = nextEpisode {
            let seasonString = "S\(String(format: "%02d", episode.seasonNumber))"
            let episodeString = "E\(String(format: "%02d", episode.episodeNumber))"
            
            return "\(seasonString)\(episodeString): \(episode.title)"
        }
        
        return "No more episodes left"
    }
    
    public var nextEpisodeToWatchOnlyPrefixes: String {
        if let episode = nextEpisode {
            let seasonString = "S\(String(format: "%02d", episode.seasonNumber))"
            let episodeString = "E\(String(format: "%02d", episode.episodeNumber))"
            
            return "\(seasonString)\(episodeString)"
        }
        
        return "✅"
    }
}

// MARK: Image Properties

extension Show {
    public var poster: Data? {
        guard let images = showImages?.allObjects as? [ShowImage] else { return nil }
        guard let poster = images.first(where: { $0.isPoster == true }) else { return nil }
        
        return poster.fileData
    }
    
    public var backdrop: Data? {
        guard let images = showImages?.allObjects as? [ShowImage] else { return nil }
        guard let poster = images.first(where: { $0.isPoster == false }) else { return nil }
        
        return poster.fileData
    }
}
