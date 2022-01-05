//
//  ShowDetailsResponse.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.02.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import Foundation

struct ShowDetailsResponse: Decodable {
    var backdrop_path: String?
    var episode_run_time: [Int]?
    var first_air_date: String?
    var genres: [GenreResponse]?
    var homepage: String?
    var id: Int
    var in_production: Bool?
    var languages: [String]?
    var last_air_date: String?
//    "last_episode_to_air": {
//      "air_date": "2019-10-13",
//      "episode_number": 10,
//      "id": 1943590,
//      "name": "This Is Not for Tears",
//      "overview": "Logan weighs whether a member of the family, or a top lieutenant, will need to be sacrificed to salvage the company's tarnished reputation. Roman shares his hesitations about a new source of financing, as Kendall suggests a familiar alternative. Season Two Finale.",
//      "production_code": "",
//      "season_number": 2,
//      "still_path": "/8HpBLD5q4kxdxbk4KGx9JXPFum3.jpg",
//      "vote_average": 9.0,
//      "vote_count": 3
//    },
    var name: String
//    "next_episode_to_air": null,
    var networks: [NetworkResponse]?
    var number_of_episodes: Int?
    var number_of_seasons: Int?
//    "origin_country": [
//      "US"
//    ],
    var original_language: String?
    var original_name: String?
    var overview: String?
    var popularity: Double
    var poster_path: String
    var poster_data: Data?
    var seasons: [ShowSeasonResponse]
//    "spoken_languages": [
//      {
//        "english_name": "English",
//        "iso_639_1": "en",
//        "name": "English"
//      }
//    ],
    var status: String?
    var tagline: String?
    var type: String?
    var vote_average: Float?
    var vote_count: Int?
    var videos: VideoResponses?
}

extension ShowDetailsResponse {
    var wrappedYear: Int? {
        if let firstAirDate = first_air_date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: firstAirDate)!
            
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: date)
            
            return Int(year)
        }

        return nil
    }
    
    var wrappedYearString: String {
        if let year = wrappedYear {
            return "\(year)"
        }

        return "Unknown year"
    }
    
    public var wrappedOverview: String {
        overview ?? "Unknown overview"
    }
    
    var wrappedGenre: String {
        if let genreList = genres {
            if let genre = genreList.first {
                return genre.name
            }
        }
        
        return "Unknown genre"
    }
    
    var genreAsStringArray: [String] {
        if let genreList = genres {
            var genres = [String]()
            
            genreList.forEach { item in
                genres.append(item.name)
            }
            
            return genres
        }
        
        return []
    }
    
    var wrappedRatingString: String {
        if let rating = vote_average {
            return "\(rating)"
        }
        
        return "Unknown rating"
    }
    
    var wrappedStatus: String {
        if status == "Returning Series" {
            return "Returning"
        } else if status == "Ended" {
            return "Ended"
        }
        
        return "Unknown status"
    }
    
    var wrappedAirs: String {
        return "Unknown air time"
    }
    
    var wrappedRuntime: String {
        if let runtimeList = episode_run_time {
            if let runtime = runtimeList.first {
                return "\(runtime)"
            }
        }
        
        return "Unknown runtime"
    }
    
    var wrappedNetwork: String {
        if let networkList = networks {
            if let network = networkList.first {
                return network.name
            }
        }
        
        return "Unknown network"
    }
    
    var wrappedFirstAired: String {
        if let firstAirDate = first_air_date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: firstAirDate)!
            
            dateFormatter.dateFormat = "d. MMMM yyyy"
            let year = dateFormatter.string(from: date)
            
            return "\(year)"
        }
        
        return "Unknown first aired date"
    }
    
    var wrappedTrailer: String? {
        return nil
    }
}
