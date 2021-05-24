//
//  NetworkService+Show.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 12.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

extension NetworkService {
    func getShowDetails(showId: Int, completion: @escaping (Result<ShowDetailsResponse, Error>) -> Void) {
        tmdbProvider.request(.getShowDetails(id: showId)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let show = try filteredResponse.map(ShowDetailsResponse.self)
                    completion(.success(show))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllSeasons(show: ShowDetailsResponse, completion: @escaping (Result<[ShowSeasonResponse], Error>) -> Void) {
        let fetchGroup = DispatchGroup()
        var seasons = [ShowSeasonResponse]()
        
        show.seasons.forEach { season in
            fetchGroup.enter()
            
            tmdbProvider.request(.getShowSeason(showId: show.id, season: season.season_number)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                        let season = try filteredResponse.map(ShowSeasonResponse.self)
                        seasons.append(season)
                        fetchGroup.leave()
                    } catch {
                        completion(.failure(error))
                        fetchGroup.leave()
                    }
                case let .failure(error):
                    completion(.failure(error))
                    fetchGroup.leave()
                }
            }
        }
        
        fetchGroup.notify(queue: .main) {
            completion(.success(seasons))
        }
    }
}
