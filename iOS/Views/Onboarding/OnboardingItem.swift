//
//  OnboardingItem.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 31.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct OnboardingItem: View {
    var title: String
    var text: String
    var iconName: String
    
    var body: some View {
        HStack (alignment: .center, spacing: 10) {
            ZStack(alignment: .center) {
                Image(systemName: iconName)
                    .foregroundColor(Color("tintColor"))
                    .font(Font.system(size: 32, weight: .bold))
            }.frame(width: 72, height: 72)
            VStack (alignment: .leading, spacing: 10) {
                Text(title)
                    .font(Font.headline.bold())
                Text(text)
                    .font(.callout)
            }
        }
    }
}

//struct OnboardingItem_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingItem()
//    }
//}
