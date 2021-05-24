//
//  NetworkResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 01.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct NetworkResponse: Decodable {
    var id: Int
    var name: String
    var logo_path: String?
    var origin_country: String?
}
