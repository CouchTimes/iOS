//
//  ShowBlurredBackground.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowBlurredBackground: View {
    var poster: Image
    var posterColor: Color

    @State private var offset: CGFloat = 0
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let backgroundHeight = UIScreen.main.bounds.size.height
        
        return VStack {
            GeometryReader { geometry -> AnyView in
                let minY = geometry.frame(in: .global).minY
                
                DispatchQueue.main.async {
                    self.offset = minY
                }
                
                return AnyView (
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(posterColor)
                            .frame(width: geometry.size.width, height: minY > 0 ? backgroundHeight + minY : backgroundHeight)

                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(colorScheme == .dark ?
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.32), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom) :
                                    LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.white.opacity(0.32), Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                                )
                                .frame(width: geometry.size.width, height: backgroundHeight, alignment: .bottom)

                            Rectangle()
                                .fill(Color("backgroundColor"))
                                .frame(width: geometry.size.width, height: backgroundHeight)
                        }
                    }
                    .frame(height: minY > 0 ? backgroundHeight + minY : backgroundHeight, alignment: .center)
                )
            }
        }
    }
}
