//
//  EmptyState.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 31.10.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct EmptyState: View {
    var title: String
    var text: String
    var iconName: String
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 24) {
                Image(systemName: iconName)
                    .font(Font.system(size: 48, weight: .bold))
                    .foregroundColor(Color("tintColor"))
                VStack(alignment: .center, spacing: 10) {
                    Text(title)
                        .font(Font.title2.bold())
                    Text(text)
                        .font(.callout)
                        .foregroundColor(Color("captionColor"))
                        .multilineTextAlignment(.center)
                }.padding(.horizontal)
            }
            Spacer()
        }
    }
}

//struct EmptyState_Previews: PreviewProvider {
//    static var previews: some View {
//        EmptyState()
//    }
//}
