//
//  WatchlistViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 06.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation
import SwiftUI

class WatchlistViewModel: ObservableObject {
    private let managedObjectContext = StorageProvider.shared.persistentContainer.viewContext

    @Published var shows = [Show]()

    init() {
        fetchAllShows()
    }

    func fetchAllShows() {
        let shows = try! managedObjectContext.fetch(Show.getAllActiveShows())
        self.shows = shows
    }
}
