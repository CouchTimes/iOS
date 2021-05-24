//
//  Season+CoreDataProperties.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

extension Season {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Season> {
        return NSFetchRequest<Season>(entityName: "Season")
    }

    @NSManaged public var airedEpisodes: Int64
    @NSManaged public var episodeCount: Int64
    @NSManaged public var first_aired: Date?
    @NSManaged public var network: String?
    @NSManaged public var number: Int64
    @NSManaged public var overview: String
    @NSManaged public var title: String
    @NSManaged public var tmdbId: Int64
    @NSManaged public var traktId: Int64
    @NSManaged public var tvdbId: Int64
    @NSManaged public var rating: Float

    @NSManaged public var show: Show?
    @NSManaged public var episodes: NSSet?

    public var episodesToGo: Int {
        if self.managedObjectContext != nil {
            return episodeCount(managedObjectContext: self.managedObjectContext!)
        } else {
            return 0
        }
    }
}

// MARK: Generated accessors for episodes

extension Season {
    @objc(addEpisodesObject:)
    @NSManaged public func addToEpisodes(_ value: Episode)

    @objc(removeEpisodesObject:)
    @NSManaged public func removeFromEpisodes(_ value: Episode)

    @objc(addEpisodes:)
    @NSManaged public func addToEpisodes(_ values: NSSet)

    @objc(removeEpisodes:)
    @NSManaged public func removeFromEpisodes(_ values: NSSet)
}
