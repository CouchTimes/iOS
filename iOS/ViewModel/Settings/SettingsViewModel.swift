//
//  SettingsViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 26.09.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    private let managedContext = StorageProvider.shared.persistentContainer.viewContext
    private let defaults = UserDefaults.standard
    private var shows = [Show]()
    private var showIdsWithUpdates = [Int]()
    
    @Published var syncing = false
    @Published var lastUpdatedDate: TimeInterval
    
    init() {
        // Only of testing
//        let previousMonth = Calendar.current.date(byAdding: .year, value: -1, to: Date())
//        let testingDate = previousMonth!.timeIntervalSince1970
//        self.defaults.set(testingDate, forKey: "lastUpdatedShowData")
        
        if let lastUpdatedShowData = defaults.object(forKey:"lastUpdatedShowData") as? TimeInterval {
            lastUpdatedDate = lastUpdatedShowData
        } else {
            lastUpdatedDate = Date().timeIntervalSince1970
        }
        
        fetchAllShows()
    }
    
    var lastUpdatedDateHuman: String {
        let date = Date(timeIntervalSince1970: lastUpdatedDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    var lastUpdatedDateApi: String {
        let date = Date(timeIntervalSince1970: lastUpdatedDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
}

extension SettingsViewModel {
    private func fetchAllShows() {
        let shows = try! managedContext.fetch(Show.getAllShows())
        self.shows = shows
    }
    
    func checkForUpdates(allShows: Bool) {
        var changeIds = [Int]()
        var showIdsThatNeedUpdates = [Show]()
        
        if(allShows) {
            self.updateShows(shows)
        } else {
            NetworkService.shared.getShowChanges { result in
                switch result {
                case let .success(changes):
                    for change in changes.results {
                        changeIds.append(change.id)
                    }
                    
                    self.shows.forEach { show in
                        if changeIds.contains(Int(show.tmdbId)) {
                            showIdsThatNeedUpdates.append(show)
                        }
                    }
                    
                    self.updateShows(showIdsThatNeedUpdates)
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    private func updateShows(_ shows: [Show]) {
        let fetchGroup = DispatchGroup()
        
        shows.forEach { show in
            fetchGroup.enter()
            
            NetworkService.shared.getShowDetails(showId: Int(show.tmdbId)) { result in
                switch result {
                case let .success(showResponse):
                    NetworkService.shared.getAllSeasons(show: showResponse) { result in
                        switch result {
                        case let .success(seasons):
                            show.updateShow(managedObjectContext: self.managedContext, showResponse: showResponse, seasons: seasons)
                        case let .failure(error):
                            print(error)
                        }
                    }
                case let .failure(error):
                    print(error)
                }
                
                fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            self.syncing = false
            self.defaults.set(Date().timeIntervalSince1970, forKey: "lastUpdatedShowData")
            self.lastUpdatedDate = Date().timeIntervalSince1970
        }
    }
}
