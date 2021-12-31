//
//  ShowInfoBox.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInfoBox: View {
    var show: Show

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            ShowInfoCover(poster: Image(uiImage: showImage))
            ShowInfoTitle(title: show.title, subtitle: subtitle)
        }
    }
}

extension ShowInfoBox {
    var showImage: UIImage {
        if let poster = show.poster {
            return UIImage(data: poster)!
        }

        return UIImage(named: "cover_placeholder")!
    }
    
    var subtitle: String {
        let count = show.seasons!.count
        
        if let genres = show.genres {
            guard let genre = genres.first else { return "No genre set" }
            
            if count > 1 {
                return "\(show.year) • \(count) seasons • \(genre)"
            } else {
                return "\(show.year) • \(count) season • \(genre)"
            }
        }
        
        if count > 1 {
            return "\(show.year) • \(count) seasons"
        } else {
            return "\(show.year) • \(count) season"
        }
    }
}
