//
//  SettingsAppIconViewModel.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.11.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Foundation
import SwiftUI

class SettingsAppIconViewModel: ObservableObject {
    @Published var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        updateIconIndex()
    }
    
    private func getAlternateIconNames() {
        var alternateIconsList = [String]()
        
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            
            for (_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String,Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                
                alternateIconsList.append(icon)
            }
            
            alternateIconsList.sort { $0 < $1 }
            iconNames.append(contentsOf: alternateIconsList)
        }
    }
    
    func updateIconIndex() {
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        } else {
            self.currentIndex = 0
        }
    }
}
