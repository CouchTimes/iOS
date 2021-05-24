//
//  ShowChanges.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 04.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowChanges: Decodable {
    var results: [ShowChangesItem]
    var page: Int
    var total_pages: Int
    var total_results: Int
}
