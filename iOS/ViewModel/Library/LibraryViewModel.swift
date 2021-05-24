//
//  LibraryViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 24.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation
import SwiftUI

class LibraryViewModel: ObservableObject {
    private let moc = StorageProvider.shared.persistentContainer.viewContext

    @Published var allShows = [Show]()
    @Published var favoriteShows = [Show]()

    init() {
        fetchAllShows()
        fetchFavoriteShows()
    }

    func fetchAllShows() {
        let shows = try! moc.fetch(Show.getAllShows())
        self.allShows = shows
    }
    
    func fetchFavoriteShows() {
        let shows = try! moc.fetch(Show.getAllFavoriteShows())
        self.favoriteShows = shows
    }
}

