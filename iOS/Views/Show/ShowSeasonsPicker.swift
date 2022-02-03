//
//  ShowSeasonsPicker.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.01.22.
//  Copyright © 2022 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct ShowSeasonsPicker: View {
    var seasons: [Season]
    
    @Binding var currentSeason: Season
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var sortedSeasons: [Season] {
        return seasons.sorted(by: { $0.number < $1.number })
    }
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    ScrollViewReader { scrollView in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(height: 48)
                                VStack(alignment: .center, spacing: 24) {
                                    ForEach(sortedSeasons, id: \.self) { season in
                                        Button(action: {
                                            currentSeason = season
                                            presentationMode.wrappedValue.dismiss()
                                        }, label: {
                                            Text("Season \(season.number)")
                                                .font(season.number == currentSeason.number ? .title2 : .title3)
                                                .fontWeight(season.number == currentSeason.number ? .bold : .regular)
                                                .foregroundColor(season.number == currentSeason.number ? Color("titleColor") : Color("captionColor"))
                                        })
                                        .id(season.number)
                                        .frame(minWidth: geometry.size.width)
                                    }
                                }
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(height: 48)
                            }
                            .frame(minWidth: geometry.size.width, minHeight: geometry.size.height, alignment: .center)
                            .onAppear {
//                                scrollView.scrollTo(currentSeason.number, anchor: .center)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 192)
            }.padding(.vertical, 32)
            ZStack(alignment: .bottom) {
                VStack {
                    Rectangle()
                        .fill(colorScheme == .dark ?
                              LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(1), Color.black.opacity(1)]), startPoint: .bottom, endPoint: .top) :
                              LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
                        .frame(width: UIScreen.main.bounds.width, height: 160)
                    Spacer()
                    Rectangle()
                        .fill(colorScheme == .dark ?
                              LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(1), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom) :
                              LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
                        .frame(width: UIScreen.main.bounds.width, height: 160)
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(Font.system(size: 16, weight: .bold))
                        .padding()
                        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 100, style: .continuous))
                }).padding(.bottom, 48)
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}
