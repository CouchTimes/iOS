//
//  SearchListItemViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 27.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation
import Moya
import UIKit

class SearchListItemViewModel: ObservableObject {
    var savedShowIds: [Int]

    @Published var isAlreadySaved = false
    @Published var show: ShowDetailsResponse

    init(show: ShowDetailsResponse, savedShowIds: [Int]) {
        self.show = show
        self.savedShowIds = savedShowIds

        alreadySaved()
    }
}

extension SearchListItemViewModel {
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
}
