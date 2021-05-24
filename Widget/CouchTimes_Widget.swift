//
//  CouchTimes_Widget.swift
//  CouchTimes Widget
//
//  Created by Jan Früchtl on 29.12.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    private let managedObjectContext = StorageProvider.shared.persistentContainer.viewContext
    
    func placeholder(in context: Context) -> SimpleEntry {
        var shows = [Show]()
        shows = try! managedObjectContext.fetch(Show.getAllActiveShows())
        shows = shows.sorted { $0.episodeCount < $1.episodeCount }
        
        return SimpleEntry(date: Date(), shows: shows)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var shows = [Show]()
        shows = try! managedObjectContext.fetch(Show.getAllActiveShows())
        shows = shows.sorted { $0.episodeCount < $1.episodeCount }
        
        let entry = SimpleEntry(date: Date(), shows: shows)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        var shows = [Show]()
        shows = try! managedObjectContext.fetch(Show.getAllActiveShows())
        shows = shows.sorted { $0.episodeCount < $1.episodeCount }

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, shows: shows)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let shows: [Show]
}

struct CouchTimes_WidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var size
    @AppStorage("selectedAppearanceMode", store: UserDefaults(suiteName: "group.com.fruechtl.couchtimes")) var selectedAppearanceMode: Themes = .System

    var body: some View {
        switch size {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        case .systemLarge:
            LargeWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

@main
struct CouchTimes_Widget: Widget {
    let kind: String = "CouchTimes_Widget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CouchTimes_WidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("backgroundColor"))
                
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("Watchlist")
        .description("View the next shows on your Watchlist.")
    }
}

//struct CouchTimes_Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        CouchTimes_WidgetEntryView(entry: SimpleEntry(date: Date(), title: "Amazing"))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
