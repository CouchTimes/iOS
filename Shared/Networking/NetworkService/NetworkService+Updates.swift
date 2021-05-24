//
//  NetworkService+Updates.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 04.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

extension NetworkService {
    func getShowChanges(completion: @escaping (Result<ShowChanges, Error>) -> Void) {
        tmdbProvider.request(.getTVChanges) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let changes = try filteredResponse.map(ShowChanges.self)
                    completion(.success(changes))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
