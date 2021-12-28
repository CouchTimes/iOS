//
//  SyncProvider.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 28.12.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import CoreData

class SyncProvider {
    static let shared = SyncProvider()
    private let managedContext = StorageProvider.shared.persistentContainer.viewContext
    
    // Check if some shows have updates available and
    // return an Array of shows that need an update
    func checkForUpdatedShows(_ shows: [Show], completion: @escaping (Result<[Show], Error>) -> Void) {
        var showChangesIds = [Int]()
        var showRequiresUpdate = [Show]()
        
        print("checkForUpdatedShows")
        print(shows)
        
        NetworkService.shared.getShowChanges { result in
            switch result {
            case let .success(changes):
                print(changes.results)
                for change in changes.results {
                    showChangesIds.append(change.id)
                }
                
                shows.forEach { show in
                    if showChangesIds.contains(Int(show.tmdbId)) {
                        showRequiresUpdate.append(show)
                    }
                }
                
                completion(.success(showRequiresUpdate))
                
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func updateShows(_ shows: [Show], completion: @escaping (Result<String, Error>) -> Void) {
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
                            completion(.failure(error))
                        }
                    }
                case let .failure(error):
                    print(error)
                    completion(.failure(error))
                }
                    
                fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            completion(.success("Test"))
        }
    }
}
