//
//  NetworkService.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 28.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Alamofire
import Foundation
import Moya

class NetworkService {
    let tmdbProvider = MoyaProvider<TMDbService>()

    static let shared = NetworkService()
}

extension NetworkService {
    func getFullShowData(shows: [ShowResponse], completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        self.getShowDetails(shows: shows) { result in
            switch result {
                case let .success(shows):
                    self.getShowImageDataForMultipleShows(shows: shows) { result in
                        switch result {
                            case let .success(showsWithImages):
                                completion(.success(showsWithImages))
                            case let .failure(error):
                                completion(.failure(error))
                                // TODO: Add error handling
                        }
                    }
                case let .failure(error):
                    completion(.failure(error))
                    // TODO: Add error handling
            }
        }
    }
    
    func getShowDetails(shows: [ShowResponse], completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        let fetchGroup = DispatchGroup()
        var showsWithDetails = [ShowDetailsResponse]()
        
        shows.forEach { show in
            fetchGroup.enter()
            
            self.getShowDetails(showId: show.id) { result in
                switch result {
                case let .success(show):
                    showsWithDetails.append(show)
                    fetchGroup.leave()
                case let .failure(error):
                    fetchGroup.leave()
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            }
        }
        
        fetchGroup.notify(queue: .main) {
            completion(.success(showsWithDetails))
        }
    }
    
    func getShowImageDataForMultipleShows(shows: [ShowDetailsResponse], completion: @escaping (Result<[ShowDetailsResponse], Error>) -> Void) {
        let fetchGroup = DispatchGroup()
        var newShows = [ShowDetailsResponse]()
        
        shows.forEach { show in
            fetchGroup.enter()
            
            getShowImageData(show: show) { showWithImage in
                switch showWithImage {
                case let .success(show):
                    newShows.append(show)
                    fetchGroup.leave()
                case let .failure(error):
                    fetchGroup.leave()
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            }
        }
        
        fetchGroup.notify(queue: .main) {
            completion(.success(newShows))
        }
    }
    
    func getShowImageData(show: ShowDetailsResponse, completion: @escaping (Result<ShowDetailsResponse, Error>) -> Void) {
        if let posterPath = show.poster_path {
            downloadShowImages(filePath: posterPath) { downloadResult in
                switch downloadResult {
                case let .success(imageData):
                    var showWithImage = show
                    showWithImage.poster_data = imageData
                    completion(.success(showWithImage))
                case let .failure(error):
                    completion(.failure(error))
                    // TODO: Add error handling
                }
            }
        } else {
            completion(.failure(ImageDownloadError.noPosterPath))
            
            // TODO: Add error handling
        }
    }
    
    private func downloadShowImages(filePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.download("https://image.tmdb.org/t/p/w500\(filePath)").responseData { response in
            if let data = response.value {
                completion(.success(data))
            } else {
                completion(.failure(ImageDownloadError.downloadFailure))
                
                // TODO: Add error handling
            }
        }
    }
}

enum ImageDownloadError: Error {
    case downloadFailure
    case noPosterPath
}
