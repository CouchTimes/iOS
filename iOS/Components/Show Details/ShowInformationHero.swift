//
//  ShowInformationHero.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowInformationHero: View {    
    var cover: UIImage?
    var asyncCover: String?
    var title: String
    var year: Int?
    var genres: [String]?
    var seasonCount: Int

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            if cover != nil {
                Image(uiImage: cover!)
                    .resizable()
                    .frame(width: 212, height: 320)
                    .cornerRadius(6)
            } else {
                AsyncCover(imagePath: asyncCover!, imageSize: .medium)
                    .frame(width: 212, height: 320)
                    .cornerRadius(6)
            }
            ShowInformationTitle(title: title, subtitle: subtitle)
        }.padding(.top, 96)
    }
}

extension ShowInformationHero {
    var subtitle: String {
        if let genres = genres {
            guard let genre = genres.first else { return "No genre set" }
            
            if seasonCount > 1 {
                return "\(String(describing: year!)) • \(seasonCount) Seasons • \(genre)"
            } else {
                return "\(String(describing: year!)) • \(seasonCount) Season • \(genre)"
            }
        }
        
        if seasonCount > 1 {
            return "\(String(describing: year!)) • \(seasonCount) Seasons"
        } else {
            return "\(String(describing: year!)) • \(seasonCount) Season"
        }
    }
}
