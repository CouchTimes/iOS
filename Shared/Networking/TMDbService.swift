//
//  TMDbService.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 13.06.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Foundation
import Moya

enum TMDbService {
    case popularShows
    case topRatedShows
    case getNetworkSuggestions(id: String)
    case searchShows(query: String)
    case getShowDetails(id: Int)
    case getShowSeason(showId: Int, season: Int)
    case getTVChanges
}

extension TMDbService: TargetType {
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3")! }
    
    var apiKey: String {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
               keys = NSDictionary(contentsOfFile: path)
        } else {
            print("Please add a Keys.plist which includes a 'tmdb_api_key' key to store your TMDb API key.")
        }
        
        return keys!.object(forKey: "tmdb_api_key") as! String
    }
    
    var path: String {
        switch self {
        case .popularShows:
            return "/tv/popular"
        case .topRatedShows:
            return "/tv/top_rated"
        case .getNetworkSuggestions:
            return "discover/tv"
        case .searchShows(query: _):
            return "/search/tv"
        case .getShowDetails(let id):
            return "/tv/\(id)"
        case .getShowSeason(let showId, let season):
            return "/tv/\(showId)/season/\(season)"
        case .getTVChanges:
            return "/tv/changes"
        }
    }

    var method: Moya.Method {
        switch self {
        case .popularShows, .topRatedShows, .getNetworkSuggestions, .searchShows, .getShowDetails, .getShowSeason, .getTVChanges:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .popularShows, .topRatedShows, .getTVChanges:
            return .requestPlain
        case let .getNetworkSuggestions(id):
            return .requestParameters(parameters: ["with_networks": id, "sort_by": "popularity.desc"], encoding: URLEncoding.queryString)
        case let .searchShows(query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
        case .getShowDetails, .getShowSeason:
            return .requestParameters(parameters: ["append_to_response": "images"], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        switch self {
        case .popularShows:
            guard let url = Bundle.main.url(forResource: "popularShows", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .topRatedShows:
            guard let url = Bundle.main.url(forResource: "topRatedShows", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .getNetworkSuggestions:
            guard let url = Bundle.main.url(forResource: "topRatedShows", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .searchShows(query: _):
            guard let url = Bundle.main.url(forResource: "searchShows", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .getShowDetails(id: _):
            guard let url = Bundle.main.url(forResource: "getShowDetails", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .getShowSeason(id: _):
            guard let url = Bundle.main.url(forResource: "getShowSeason", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        case .getTVChanges:
            guard let url = Bundle.main.url(forResource: "getTVChanges", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        }
    }

    var headers: [String: String]? {
        return [
            "Content-type": "application/json",
            "Authorization": "Bearer \(apiKey)",
        ]
    }
}
