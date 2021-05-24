//
//  Season+CoreDataClass.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

public class Season: NSManagedObject, Identifiable {
}

extension Season {
    func episodeCount(managedObjectContext: NSManagedObjectContext) -> Int {
        guard let episodes = self.episodes?.allObjects as? [Episode] else { return 0 }
        var episodesToGo = episodes.count

        episodes.forEach { episode in
            if episode.watched {
                episodesToGo -= 1
            }
        }

        return episodesToGo
    }
}
