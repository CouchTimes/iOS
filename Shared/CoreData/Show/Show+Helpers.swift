//
//  Show+Helpers.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 24.09.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation

extension Show {
    static func createShow(managedObjectContext: NSManagedObjectContext, showResponse: ShowDetailsResponse, seasons: [ShowSeasonResponse]) -> Show {
        let show = Show(context: managedObjectContext)
        show.updateShowFromResponse(showResponse, seasons: seasons)

        return show
    }
    
    func updateShow(managedObjectContext: NSManagedObjectContext, showResponse: ShowDetailsResponse, seasons: [ShowSeasonResponse]) {
        self.updateShowFromResponse(showResponse, seasons: seasons)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Update Error")
        }
    }
    
    static func createShowForCoreData(managedObjectContext: NSManagedObjectContext, showResponse: ShowDetailsResponse, seasons: [ShowSeasonResponse], completion: @escaping (Result<Show, Error>) -> Void) {
        let show = Show.createShow(managedObjectContext: managedObjectContext, showResponse: showResponse, seasons: seasons)

        do {
            try managedObjectContext.save()
            completion(.success(show))
        } catch {
            completion(.failure(error))
        }
    }
}
