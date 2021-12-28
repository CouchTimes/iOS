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
    
    func updateShows(forceUpdateAllShows: Bool) {
        let shows = try! managedContext.fetch(Show.getAllShows())
        self.syncing = true
        
        if forceUpdateAllShows {
            SyncProvider.shared.updateShows(shows) { result in
                switch result {
                case .success(_):
                    self.syncing = false
                case let .failure(error):
                    print(error)
                }
            }
        } else {
            SyncProvider.shared.checkForUpdatedShows(shows) { result in
                switch result {
                case let .success(show):
                    SyncProvider.shared.updateShows(show) { result in
                        switch result {
                        case .success(_):
                            self.syncing = false
                        case let .failure(error):
                            print(error)
                        }
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
