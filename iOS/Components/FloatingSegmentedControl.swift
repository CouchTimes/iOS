//
//  FloatingSegmentedControl.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.01.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct FloatingSegmentedControl: View {
    var pickerLabel: String
    var pickerItems: [String]
    
    @Binding var pickerSelection: Int
    
    var body: some View {
        Group {
            Picker(selection: $pickerSelection, label: Text(pickerLabel)) {
                ForEach(Array(pickerItems.enumerated()), id: \.offset) { index, item in
                    Text(item).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .cornerRadius(8)
        .background(Color("cardBackground"))
        .padding(.horizontal)
        .padding(.bottom)
    }
}
