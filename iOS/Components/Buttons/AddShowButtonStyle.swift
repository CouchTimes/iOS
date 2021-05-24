//
//  AddShowButtonStyle.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct AddShowButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    var buttonGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(gradient: Gradient(colors: [
                Color(UIColor(red: 0.451, green: 0.451, blue: 0.988, alpha: 1)),
                Color(UIColor(red: 0.217, green: 0.217, blue: 0.983, alpha: 1)),
            ]), startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(gradient: Gradient(colors: [
                Color(UIColor(red: 0.955, green: 0.958, blue: 0.965, alpha: 1)),
                Color(UIColor(red: 0.865, green: 0.873, blue: 0.895, alpha: 1)),
            ]), startPoint: .top, endPoint: .bottom)
        }
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(buttonGradient)
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .font(Font.system(size: 18, weight: .bold))
    }
}

struct AddShowButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Add To Watchlist")
        }.buttonStyle(AddShowButtonStyle())
    }
}
