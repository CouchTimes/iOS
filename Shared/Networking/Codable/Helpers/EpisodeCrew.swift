//
//  EpisodeCrew.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct EpisodeCrew: Decodable {
    var job: String
    var department: String
    var credit_id: String
    var adult: Bool
    var gender: Int
    var id: Int
    var known_for_department: String
    var name: String
    var original_name: String
    var popularity: Float
//    var profile_path: String
}
