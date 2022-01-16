//
//  SearchItemViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 27.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation
import Moya
import UIKit

class SearchItemViewModel: ObservableObject {
    private var savedShowIds: [Int]
    
    @Published var isSavingShow = false
    @Published var isAlreadySaved = false
    @Published var show: ShowDetailsResponse

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        self.show = show
        self.savedShowIds = savedShowIds

        alreadySaved()
    }
}

extension SearchItemViewModel {
    private func alreadySaved() {
        for id in savedShowIds {
            if id == show.id {
                isAlreadySaved = true
                return
            }
        }

        isAlreadySaved = false
    }
    
    private func searchShowById(_ id: Int, completion: @escaping (ShowDetailsResponse?) -> Void) {
        NetworkService.shared.getShowDetails(showId: id) { result in
            switch result {
            case let .success(show):
                completion(show)

            case .failure:
                completion(nil)
            }
        }
    }
    
    func getFullShowData() {
        NetworkService.shared.getShowImageData(show: show) { result in
            switch result {
            case let .success(show):
                self.show = show
                
                NetworkService.shared.getAllSeasons(show: show) { result in
                    switch result {
                    case let .success(seasons):
                        self.show.seasons = seasons
                    case let .failure(error):
                        print(error)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func saveShow(completion: @escaping (Result<Show, Error>) -> Void) {
        let managedContext = StorageProvider.shared.persistentContainer.viewContext
        
        self.isSavingShow = true
        
        Show.createShowForCoreData(managedObjectContext: managedContext, showResponse: show, seasons: show.seasons) { result in
            switch result {
            case let .success(coreDataShow):
                completion(.success(coreDataShow))
                print("Successfully saved!")
            case let .failure(error):
                print("Error while saving")
                print(error)
                completion(.failure(error))
            }
            
            self.isSavingShow = false
        }
    }
}
