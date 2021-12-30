//
//  Episode+CoreDataClass.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

public class Episode: NSManagedObject, Identifiable {
    static func getNextEpisode(episodeId: Int) -> NSFetchRequest<Episode> {
        let request: NSFetchRequest<Episode> = Episode.fetchRequest()
        
        // TODO - Move to TMDb
        let predicate = NSPredicate(format: "traktId == %i", episodeId)
        
        request.predicate = predicate
        
        return request
    }
    
    public func toggleWatchedStatus() {
        guard let managedObjectContext = self.managedObjectContext else {
            print("Couldn't unwrap the managedObjectContext (CoreData) from the show object.")
            return
        }
        
        managedObjectContext.performAndWait {
            self.watched = !self.watched
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}
