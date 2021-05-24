//
//  SearchResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 21.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [ShowResponse]
}
