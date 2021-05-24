//
//  DesignTokens.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 04.07.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import Foundation
import SwiftUI

struct TokensLight {
    let PRIMARY_BUTTON_GRADIENT = LinearGradient(gradient: Gradient(colors: [
        Color(UIColor(red: 0.955, green: 0.958, blue: 0.965, alpha: 1)),
        Color(UIColor(red: 0.865, green: 0.873, blue: 0.895, alpha: 1)),
    ]), startPoint: .top, endPoint: .bottom)
}

struct TokensDark {
    let PRIMARY_BUTTON_GRADIENT = LinearGradient(gradient: Gradient(colors: [
        Color(UIColor(red: 0.957, green: 0.586, blue: 0.163, alpha: 1)),
        Color(UIColor(red: 0.837, green: 0.466, blue: 0.043, alpha: 1)),
    ]), startPoint: .top, endPoint: .bottom)
}

struct Tokens {
    static let Light = TokensLight()
    static let Dark = TokensLight()
}
