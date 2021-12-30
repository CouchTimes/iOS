//
//  SeasonViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 13.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Combine
import CoreData
import Foundation
import SwiftUI
import WidgetKit

class SeasonDetailViewViewModel: ObservableObject {
    private let managedObjectContext = StorageProvider.shared.persistentContainer.viewContext

    @Published var show: Show
    @Published var season: Season
    @Published var episodes = [Episode]()
    @Published var allEpisodesWatched = true

    init(show: Show, season: Season) {
        self.show = show
        self.season = season
    }
}

extension SeasonDetailViewViewModel {
    func getAllEpisodes() {
        guard let episodeSet = season.episodes else { return }

        var episodeArray = episodeSet.allObjects as! [Episode]
        episodeArray = episodeArray.sorted { $0.episodeNumber < $1.episodeNumber }

        episodes = episodeArray
    }

    func markAllEpisodesAsWatched(season: Season) {
        guard let episodes = season.episodes?.allObjects as? [Episode]  else { return }
        let watchableEpisodes = episodes.filter { $0.watchable == true }
        
        managedObjectContext.performAndWait {
            watchableEpisodes.forEach { episode in
                episode.watched = true
                
                
                do {
                    try managedObjectContext.save()
                    self.isThisSeasonWatched()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func isThisSeasonWatched() {
        guard let episodes = season.episodes?.allObjects as? [Episode]  else { return }
        let watchableEpisodes = episodes.filter { $0.watchable == true }
        
        var status = true
        
        watchableEpisodes.forEach { episode in
            if !episode.watched {
                status = false
                return
            }
        }
        
        allEpisodesWatched = status
    }
}
