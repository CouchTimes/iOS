//
//  NetworkService+Search.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 28.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Foundation

extension NetworkService {
    func getPopularShows(completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        tmdbProvider.request(.popularShows) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let shows = try filteredResponse.map(SearchResponse.self)
                    
                    self.getShowDetails(shows: shows.results) { result in
                        switch result {
                        case let .success(shows):
                            completion(.success(shows))
                        case let .failure(error):
                            completion(.failure(error))
                            // TODO: Add error handling
                        }
                    }
                } catch {
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getTopRatedShows(completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        tmdbProvider.request(.topRatedShows) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let shows = try filteredResponse.map(SearchResponse.self)
                    
                    self.getShowDetails(shows: shows.results) { result in
                        switch result {
                        case let .success(shows):
                            completion(.success(shows))
                        case let .failure(error):
                            completion(.failure(error))
                            // TODO: Add error handling
                        }
                    }
                } catch {
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getNetworkRecommendation(networkId: String, completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        tmdbProvider.request(.getNetworkSuggestions(id: networkId)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let shows = try filteredResponse.map(SearchResponse.self)
                    
                    self.getShowDetails(shows: shows.results) { result in
                        switch result {
                        case let .success(shows):
                            completion(.success(shows))
                        case let .failure(error):
                            completion(.failure(error))
                            // TODO: Add error handling
                        }
                    }
                } catch {
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func searchShowByName(_ name: String, completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        tmdbProvider.request(.searchShows(query: name)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let shows = try filteredResponse.map(SearchResponse.self)
                    
                    self.getShowDetails(shows: shows.results) { result in
                        switch result {
                        case let .success(shows):
                            completion(.success(shows))
                        case let .failure(error):
                            completion(.failure(error))
                            // TODO: Add error handling
                        }
                    }
                } catch {
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            case let .failure(error):
                completion(.failure(error))
            // TODO: Add error handling
            }
        }
    }
}
