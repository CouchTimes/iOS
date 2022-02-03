//
//  CustomSegmentedControl.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 03.02.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding public var selection: Int
    
    private let size: CGSize
    private let segmentLabels: [String]
    private let segmentPadding: CGFloat = 2
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: size.width, height: size.height)
                .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 100, style: .continuous))
                .foregroundColor(.clear)
            
            RoundedRectangle(cornerRadius: 100)
                .frame(width: segmentWidth(size) - (segmentPadding * 2), height: size.height - (segmentPadding * 2))
                .foregroundColor(Color(uiColor: UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 1)))
                .offset(x: calculateSegmentOffset(size) + segmentPadding)
                .animation(.easeOut(duration: 0.4), value: calculateSegmentOffset(size) + segmentPadding)
            
            HStack(spacing: 0) {
                ForEach(0..<segmentLabels.count) { idx in
                    SegmentLabel(selection: $selection, id: idx, title: segmentLabels[idx], width: segmentWidth(size), textColour: Color("titleColor"))
                }
            }
        }
    }
    
    public init(selection: Binding<Int>, size: CGSize, segmentLabels: [String]) {
        self._selection = selection
        self.size = size
        self.segmentLabels = segmentLabels
    }
    
    private func segmentWidth(_ mainSize: CGSize) -> CGFloat {
        var width = (mainSize.width / CGFloat(segmentLabels.count))
        if width < 0 {
            width = 0
        }
        return width
    }
    
    private func calculateSegmentOffset(_ mainSize: CGSize) -> CGFloat {
        segmentWidth(mainSize) * CGFloat(selection)
    }
}

struct SegmentLabel: View {
    @Binding var selection: Int
    let id: Int
    let title: String
    let width: CGFloat
    let textColour: Color
    
    var body: some View {
        Button(action: {
            selection = id
        }, label: {
            Text(title)
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: false)
                .foregroundColor(textColour)
                .frame(width: width)
                .contentShape(Rectangle())
        })
    }
}
