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

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                poster
                    .resizable()
                    .frame(width: geometry.size.width, height: UIScreen.main.bounds.size.height)
                    .blur(radius: 16.0, opaque: true)

                VStack(spacing: 0) {
                    Rectangle()
                        .fill(colorScheme == .dark ?
                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.08), Color.black.opacity(0.32), Color.black.opacity(0.64), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom) :
                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.48), Color.white.opacity(0.64), Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: geometry.size.width, height: UIScreen.main.bounds.size.height / 1.65)

                    Rectangle()
                        .fill(Color("backgroundColor"))
                        .frame(width: geometry.size.width, height: UIScreen.main.bounds.size.height / 1.65)
                }
            }
        }
    }
}

struct ShowBlurredBackground_Previews: PreviewProvider {
    static var previews: some View {
        ShowBlurredBackground(poster: Image("cover_placeholder"))
    }
}
