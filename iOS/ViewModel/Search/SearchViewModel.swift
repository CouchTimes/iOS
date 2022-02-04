//
//  SearchViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 21.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Combine
import CoreData
import Foundation
import UIKit

class SearchViewModel: ObservableObject {
    private var cancellables = [AnyCancellable]()
    
    @Published var isLoading = false
    
    @Published var savedShows = [Int]()
    @Published var searchedShows = [ShowDetailsResponse]()

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
    
    func getSearchRecommendations(type: SearchRecommendationType) {
        self.isLoading = true
        
        switch type {
        case .popular:
            self.getPopularShows()
        case .topRated:
            self.getRecommendedShows()
        case .netflix:
            self.getNetflixSuggestions()
        case .apple:
            self.getAppleSuggestions()
        case .hbo:
            self.getHBOSuggestions()
        case .disney:
            self.getDisneySuggestions()
        case .amazon:
            self.getAmazonSuggestions()
        case .hulu:
            self.getHuluSuggestions()
        case .showtime:
            self.getShowtimeSuggestions()
        case .syfy:
            self.getSyfySuggestions()
        }
    }

    private func getPopularShows() {
        NetworkService.shared.getPopularShows { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }

    private func getRecommendedShows() {
        NetworkService.shared.getTopRatedShows { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getNetflixSuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "213") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getAppleSuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "2552") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getDisneySuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "2739") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getAmazonSuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "1024") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getHBOSuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "49") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getHuluSuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "453") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getShowtimeSuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "67") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getSyfySuggestions() {
        NetworkService.shared.getNetworkRecommendation(networkId: "77") { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows.sorted(by: { $0.popularity > $1.popularity })
                self.isLoading = false
            case let .failure(error):
                print(error)
            }
        }
    }

    func searchShowByName(_ name: String) {
        NetworkService.shared.searchShowByName(name) { result in
            switch result {
            case let .success(shows):
                self.searchedShows = shows
                self.isLoading = false

            case let .failure(error):
                print(error)
            }
        }
    }
}

enum SearchRecommendationType {
    case popular
    case topRated
    case netflix
    case apple
    case hbo
    case disney
    case amazon
    case hulu
    case showtime
    case syfy
}

extension SearchViewModel {
    private func getAllSavedShows(moc: NSManagedObjectContext) {
        let shows = try! moc.fetch(Show.getAllShows())
        var showIds = [Int]()

        for show in shows {
            showIds.append(Int(show.tmdbId))
        }

        savedShows = showIds
    }
}
