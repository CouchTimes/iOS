//
//  SettingsAppIcon.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 11.11.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SettingsAppIcon: View {
    @StateObject private var viewModel = SettingsAppIconViewModel()
    
    var body: some View {
        List {
            ForEach(0..<viewModel.iconNames.count, id: \.self) { index in
                HStack {
                    HStack(alignment: .center, spacing: 10) {
                        Image(uiImage: UIImage(named: viewModel.iconNames[index] ?? "AppIcon") ?? UIImage())
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 48, height: 48)
                            .cornerRadius(8)
                        Text(viewModel.iconNames[index] ?? "Default")
                    }.padding(.vertical, 8)
                    Spacer()
                    if index == viewModel.currentIndex {
                        Image(systemName: "checkmark.circle.fill")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(Color("tintColor"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    UIApplication.shared.setAlternateIconName(viewModel.iconNames[index]){ error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            viewModel.updateIconIndex()
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("App Icon", displayMode: .inline)
    }
}

struct SettingsAppIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAppIcon()
    }
}
