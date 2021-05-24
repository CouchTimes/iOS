//
//  Episode+CoreDataProperties.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.01.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

extension Episode {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Episode> {
        return NSFetchRequest<Episode>(entityName: "Episode")
    }

    @NSManaged public var availableTranslations: [String]?
    @NSManaged public var episodeNumber: Int16
    @NSManaged public var first_aired: Date?
    @NSManaged public var imdbId: String
    @NSManaged public var numberAbsolute: Int16
    @NSManaged public var overview: String
    @NSManaged public var rating: Float
    @NSManaged public var runtime: Int16
    @NSManaged public var seasonNumber: Int16
    @NSManaged public var title: String
    @NSManaged public var tmdbId: Int64
    @NSManaged public var traktId: Int64
    @NSManaged public var tvdbId: Int64
    @NSManaged public var updatedAt: Date
    @NSManaged public var watched: Bool
    
    @NSManaged public var season: Season?
    @NSManaged public var show: Show?
}

extension Episode {
    public var wrappedFirstAirDate: String {
        if let date = first_aired {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            return formatter.string(from: date)
        }
        return "Unknown first air date"
    }
    
    public var watchable: Bool {
        let now = Date()
        guard let airDate = first_aired else { return false }
        
        let watchable = now > airDate ? true : false
        
        return watchable
    }
}
