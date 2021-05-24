//
//  Show+CoreDataProperties.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

extension Show {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Show> {
        return NSFetchRequest<Show>(entityName: "Show")
    }

    @NSManaged public var airedEpisodes: Int64
    @NSManaged public var airsDay: String?
    @NSManaged public var airsTime: String?
    @NSManaged public var airsTimezone: String?

    @NSManaged public var availableTranslations: [String]?
    @NSManaged public var certification: String?
    @NSManaged public var country: String?
    @NSManaged public var firstAirDate: Date?
    @NSManaged public var genres: [String]?
    @NSManaged public var homepage: String?
    @NSManaged public var imdbId: String?
    @NSManaged public var language: String?
    @NSManaged public var network: String?
    @NSManaged public var overview: String?

    @NSManaged public var rating: Float
    @NSManaged public var runtime: Int64
    @NSManaged public var slug: String?
    @NSManaged public var status: String?
    @NSManaged public var title: String

    @NSManaged public var tmdbId: Int64
    @NSManaged public var trailer: String?
    @NSManaged public var traktId: Int64
    @NSManaged public var tvdbId: Int64
    @NSManaged public var updatedAt: Date
    @NSManaged public var year: Int64
    
    @NSManaged public var isActive: Bool
    @NSManaged public var isFavorite: Bool

    @NSManaged public var seasons: NSSet?
    @NSManaged public var episodes: NSSet?
    @NSManaged public var showImages: NSSet?
}

// MARK: Generated accessors for seasons

extension Show {
    @objc(addSeasonsObject:)
    @NSManaged public func addToSeasons(_ value: Season)

    @objc(removeSeasonsObject:)
    @NSManaged public func removeFromSeasons(_ value: Season)

    @objc(addSeasons:)
    @NSManaged public func addToSeasons(_ values: NSSet)

    @objc(removeSeasons:)
    @NSManaged public func removeFromSeasons(_ values: NSSet)

    @objc(addShowImagesObject:)
    @NSManaged public func addToShowImages(_ value: ShowImage)

    @objc(removeShowImagesObject:)
    @NSManaged public func removeFromShowImages(_ value: ShowImage)
}
