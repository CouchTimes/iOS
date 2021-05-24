//
//  ShowViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 01.01.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation
import SwiftUI

class ShowViewModel: ObservableObject {
    private let managedObjectContext = StorageProvider.shared.persistentContainer.viewContext

    @Published var show: Show?
    @Published var seasons = [Season]()
    @Published var episodes = [Episode]()
    @Published var watchedStatus = true
    
    init(showId: Int) {
        fetchShowById(showId)
        getAllEpisodes()
        getAllSeasons()
        showWatched()
    }
}

extension ShowViewModel {
    func fetchShowById(_ showId: Int) {
        let fetchResult = try! managedObjectContext.fetch(Show.getSingleShows(showId: showId))
        
        if let result = fetchResult.first {
            self.show = result
        } else {
            self.show = nil
        }
    }
    
    func getAllSeasons() {
        guard let wrappedShow = show else { return }
        guard let seasonArray = wrappedShow.getAllSeasons() else { return }

        seasons = seasonArray
    }
    
    func getAllEpisodes() {
        guard let wrappedShow = show else { return }
        guard let episodesArray = wrappedShow.getAllEpisodes() else { return }

        episodes = episodesArray
    }
    
    func markAllEpisodesAsWatched() {
        guard let wrappedShow = show else { return }
        wrappedShow.markAllEpisodesAsWatched(managedObjectContext: managedObjectContext)
    }
    
    func showWatched() {
        let watchableEpisodes = episodes.filter { $0.watchable == true }
        
        var status = true
        
        watchableEpisodes.forEach { episode in
            if !episode.watched {
                status = false
                return
            }
        }
        
        watchedStatus = status
    }
    
    func toggleWatchlistStatus() -> Void {
        guard let wrappedShow = show else { return }
        wrappedShow.toggleWatchlistMode(managedObjectContext: managedObjectContext)
    }
    
    func toggleFavoriteStatus() -> Void {
        guard let wrappedShow = show else { return }
        wrappedShow.toggleFavoriteMode(managedObjectContext: managedObjectContext)
    }
    
    func deleteShow() -> Void {
        guard let wrappedShow = show else { return }
        wrappedShow.deleteShow(managedObjectContext: managedObjectContext)
    }
}
