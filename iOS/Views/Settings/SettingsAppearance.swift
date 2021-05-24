//
//  SettingsAppearance.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 19.11.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SettingsAppearance: View {
    private var appearanceMode = ["System", "Dark", "Light"]
    @AppStorage("selectedAppearanceMode", store: UserDefaults(suiteName: "group.com.fruechtl.couchtimes")) var selectedAppearanceMode: Themes = .System
    
    var body: some View {
        List {
            ForEach(0..<appearanceMode.count, id: \.self) { index in
                HStack {
                    Text(appearanceMode[index])
                    Spacer()
                    if appearanceMode[index] == selectedAppearanceMode.rawValue {
                        Image(systemName: "checkmark.circle.fill")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(Color("tintColor"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if appearanceMode[index] == "System" {
                        selectedAppearanceMode = .System
                        SceneDelegate.shared?.window!.overrideUserInterfaceStyle = .unspecified
                    }
                    
                    if appearanceMode[index] == "Dark" {
                        selectedAppearanceMode = .Dark
                        SceneDelegate.shared?.window!.overrideUserInterfaceStyle = .dark
                    }
                    
                    if appearanceMode[index] == "Light" {
                        selectedAppearanceMode = .Light
                        SceneDelegate.shared?.window!.overrideUserInterfaceStyle = .light
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Appearance", displayMode: .inline)
    }
}

//struct SettingsAppearance_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsAppearance()
//    }
//}
