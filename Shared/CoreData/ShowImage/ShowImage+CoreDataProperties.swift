//
//  ShowImage+CoreDataProperties.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 22.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//
//

import CoreData
import Foundation

extension ShowImage {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShowImage> {
        return NSFetchRequest<ShowImage>(entityName: "ShowImage")
    }

    @NSManaged public var type: String
    @NSManaged public var aspectRatio: Float
    @NSManaged public var filePath: String?
    @NSManaged public var fileData: Data?
    @NSManaged public var isPoster: Bool
    @NSManaged public var show: Show?
}
