//
//  WatchlistCell.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.10.19.
//  Copyright © 2019 Jan Früchtl. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WatchlistCell: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    @State private var isPresented = false
    @Binding var show: Show
    
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { _ in
                if self.offset.width < 0 && abs(self.offset.width) > 128 && show.nextEpisode != nil {
                    managedObjectContext.performAndWait {
                        show.nextEpisode!.watched = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            do {
                                try managedObjectContext.save()
                                WidgetCenter.shared.reloadAllTimelines()
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
        ZStack {
            ZStack(alignment: .trailing) {
                if show.nextEpisode != nil {
                    Rectangle()
                        .fill(Color.green)
                    Image(systemName: "checkmark.circle.fill")
                        .imageScale(.large)
                        .padding(.trailing, 48)
                }
            }
            Button(action: {
                self.isPresented.toggle()
            }) {
                HStack(alignment: .center, spacing: 16) {
                    WatchlistCover(cover: show.poster)
                    WatchlistCellContent(title: show.title, nextEpisode: show.nextEpisodeToWatch)
                    Spacer()
                    WatchlistCellEpisodeCounter(text: count)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .background(Color("backgroundColor"))
                .offset(CGSize(width: offset.width < -24 ? offset.width : 0 , height: 0))
                .gesture(show.nextEpisode != nil ? dragGesture: nil)
            }
            .sheet(isPresented: $isPresented) {
                ShowDetail(showId: Int(show.tmdbId))
            }
            .buttonStyle(MyButtonStyle())
        }
    }
}

struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
  }
}

extension WatchlistCell {
    var count: String {
        String(describing: show.episodeCount)
    }
}
