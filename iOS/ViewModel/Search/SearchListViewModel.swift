//
//  SearchListViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 21.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Combine
import CoreData
import Foundation
import UIKit

class SearchListViewModel: ObservableObject {
    @Published var savedShows = [Int]()
    private var cancellables = [AnyCancellable]()

    init() {
        let moc = StorageProvider.shared.persistentContainer.viewContext

        getAllSavedShows(moc: moc)

        let cancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextObjectsDidChange, object: moc)
            .compactMap { $0 }.sink { _ in
                self.getAllSavedShows(moc: moc)
            }
        cancellables.append(cancellable)
    }
}

extension SearchListViewModel {
    private func getAllSavedShows(moc: NSManagedObjectContext) {
        let shows = try! moc.fetch(Show.getAllShows())
        var showIds = [Int]()

        for show in shows {
            showIds.append(Int(show.tmdbId))
        }

        savedShows = showIds
    }
}
