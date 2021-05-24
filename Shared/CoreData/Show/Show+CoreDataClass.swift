//
//  Show+CoreDataClass.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

public class Show: NSManagedObject, Identifiable {
    public func getAllSeasons() -> [Season]? {
        guard let seasons = self.seasons else { return nil }
        
        var seasonsArray = seasons.allObjects as! [Season]
        seasonsArray = seasonsArray.sorted { $0.number < $1.number }
        
        return seasonsArray
    }
    
    public func getAllEpisodes() -> [Episode]? {
        guard let episodes = self.episodes else { return nil }
        
        var episodesArray = episodes.allObjects as! [Episode]
        episodesArray = episodesArray.sorted { $0.episodeNumber < $1.episodeNumber }
        
        return episodesArray
    }
    
    public func markAllEpisodesAsWatched(managedObjectContext: NSManagedObjectContext) {
        guard let episodes = self.episodes else { return }
        let episodesArray = episodes.allObjects as! [Episode]
        let watchableEpisodes = episodesArray.filter { $0.watchable == true }
        
        managedObjectContext.performAndWait {
            watchableEpisodes.forEach { episode in
                episode.watched = true
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    public func toggleWatchlistMode(managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.performAndWait {
            self.isActive = !self.isActive
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    public func toggleFavoriteMode(managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.performAndWait {
            self.isFavorite = !self.isFavorite
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    public func deleteShow(managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.performAndWait {
            managedObjectContext.delete(self)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

extension Show {
    static func getAllShows() -> NSFetchRequest<Show> {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]

        return request
    }
    
    static func getAllActiveShows() -> NSFetchRequest<Show> {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        let predicate = NSPredicate(format: "isActive = %d",  true)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]

        return request
    }
    
    static func getAllFavoriteShows() -> NSFetchRequest<Show> {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        let predicate = NSPredicate(format: "isFavorite = %d",  true)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]

        return request
    }

    static func getSingleShows(showId: Int) -> NSFetchRequest<Show> {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        
        let predicate = NSPredicate(format: "tmdbId == %i", showId)

        request.predicate = predicate

        return request
    }
}
