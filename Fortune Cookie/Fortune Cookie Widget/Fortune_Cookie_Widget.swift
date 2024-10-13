//
//  Fortune_Cookie_Widget.swift
//  Fortune Cookie Widget
//
//  Created by Cole Abrams on 8/21/24.
//

import WidgetKit
import SwiftUI
import UIKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), color: loadColor(), font: loadFont(), size: loadSize(), fortune: loadFortune())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), color: loadColor(), font: loadFont(), size: loadSize(), fortune: loadFortune())
        completion(entry)
        
//        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
//        let allWidgets = sharedDefaults?.array(forKey: "AllWidgets") as? [[String: Any]] ?? []
//
//        // Loop through the stored widgets and create snapshots for each one
//        if let widgetData = allWidgets.first {
//            if let size = widgetData["size"] as? String,
//               let colorData = widgetData["color"] as? Data,
//               let font = widgetData["font"] as? String,
//               let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? LinearGradient {
//                    let widget = WidgetModelWidget(size: size, color: color, font: font)
//                    let fortune = loadFortune()
//                    
//                    let entry = SimpleEntry(date: Date(), widget: widget, fortune: fortune)
//                    completion(entry)
//            }
//        } else {
//            // Fallback snapshot in case there are no widgets in UserDefaults
//            let entry = SimpleEntry(date: Date(), widget: WidgetConstants.defaultWidgetModelMedium, fortune: "Fortune will find you soon, just wait.")
//            completion(entry)
        
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), color: loadColor(), font: loadFont(), size: loadSize(), fortune: loadFortune())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
//        
//        
//        var entries: [SimpleEntry] = []
//        let currentDate = Date()
//
//        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
//        let allWidgets = sharedDefaults?.array(forKey: "AllWidgets") as? [[String: Any]] ?? []
//
//        for widgetData in allWidgets {
//            if let size = widgetData["size"] as? String,
//               let colorData = widgetData["color"] as? Data,
//               let font = widgetData["font"] as? String,
//               let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? LinearGradient {
//                
//                let widget = WidgetModelWidget(size: size, color: color, font: font)
//                let fortune = widgetData["fortune"] as? String ?? "Default Fortune"
//                
//                let entryDate = Calendar.current.date(byAdding: .minute, value: entries.count * 10, to: currentDate)!
//                let entry = SimpleEntry(date: entryDate, widget: widget, fortune: fortune)
//                entries.append(entry)
//            }
//        }
//
//        // Add a fallback entry if there are no widgets
//        if entries.isEmpty {
//            print("entries.isEmpty")
//            let fallbackEntry = SimpleEntry(date: currentDate, widget: WidgetConstants.defaultWidgetModelMedium, fortune: "Default Fortune")
//            entries.append(fallbackEntry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }
    
    private func loadWidget() -> WidgetModelWidget {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        
        let size: String = loadSize()
        let color: LinearGradient = loadColor()
        let font: String = loadFont()
        
        return WidgetModelWidget(size: size, color: color, font: font)
    }
    
    private func loadFortune() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        return sharedDefaults?.string(forKey: "WidgetFortune") ?? ""
    }
    
    private func loadFont() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        return sharedDefaults?.string(forKey: "WidgetFont") ?? ""
    }

    private func loadColor() -> LinearGradient {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        
        if let colorData = sharedDefaults?.data(forKey: "WidgetColor"),
           let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? LinearGradient {
            return color
            }
        
        return WidgetConstants.darkBlueGradient
    }
    
    private func loadSize() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        return sharedDefaults?.string(forKey: "WidgetSize") ?? ""
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
//    let widget: WidgetModelWidget
    var color: LinearGradient
    var font: String
    var size: String
    let fortune: String
}

struct SmallWidgetView : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.fortune)
            .font(
                Font.custom(entry.font, size: 22)
                .italic()
            )
            .foregroundColor(Color.offWhite)
            .minimumScaleFactor(0.8)
            .lineLimit(6)
            .frame(width: 120, height: 130, alignment: .topLeading)
            .padding(.top, 10)
            .multilineTextAlignment(.leading)
    }
    
}

struct MediumWidgetView : View {
    var entry: Provider.Entry
        
    var body: some View {
        
        ZStack {
            Text(entry.fortune)
                .font(
                    Font.custom(entry.font, size: 22)
                        .italic()
                )
                .foregroundColor(Color.offWhite)
                .minimumScaleFactor(0.8)
                .lineLimit(3)
                .frame(width: 250, height: 120, alignment: .topLeading)
                .padding(.top, 30)
                .multilineTextAlignment(.leading)
            
            Image("Quotation Marks")
                .frame(width: 250, height: 100, alignment: .bottomLeading)
        }
    }
}

struct Fortune_Cookie_WidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch entry.size {
        case "small":
            SmallWidgetView(entry: entry)
        case "medium":
            MediumWidgetView(entry: entry)
        default :
            MediumWidgetView(entry: entry)
        }
    }
}

struct Fortune_Cookie_Widget: Widget {
    let kind: String = "Fortune_Cookie_Widget"
    
    @Environment(\.widgetFamily) var family

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Fortune_Cookie_WidgetEntryView(entry: entry)
                .containerBackground(entry.color, for: .widget)
        }
        .configurationDisplayName("Fortune Cookie Widget")
        .description("Displays your stored fortune cookies.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
    
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            Fortune_Cookie_WidgetEntryView(entry: entry)
//                .containerBackground(entry.widget.color, for: .widget)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//        
////        .supportedFamilies([.systemSmall, .systemMedium])
////        .supportedFamilies(entry.widget.size == "medium" ? [.systemMedium] : [.systemSmall])
//    }
}

//

#Preview(as: .systemMedium) {
    Fortune_Cookie_Widget()
} timeline: {
    SimpleEntry(date: Date(), color: WidgetConstants.darkBlueGradient, font: "Times New Roman", size: "medium", fortune: "Fortune will find you soon, just wait")
}

//struct Fortune_Cookie_Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
//        let allWidgets = sharedDefaults?.array(forKey: "AllWidgets") as? [[String: Any]] ?? []
//
//        return Group {
//            ForEach(Array(allWidgets.enumerated()), id: \.offset) { index, widgetData in
//                if let size = widgetData["size"] as? String,
//                   let colorData = widgetData["color"] as? Data,
//                   let font = widgetData["font"] as? String,
//                   let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? LinearGradient {
//                    let widget = WidgetModelWidget(size: size, color: color, font: font)
//                    
//                    let fortune = "Fortune will find you soon, just wait"
//                    
//                    let entry = SimpleEntry(date: Date(), widget: widget, fortune: fortune)
//                    
//                    Fortune_Cookie_WidgetEntryView(entry: entry)
//                        .previewContext(WidgetPreviewContext(family: widget.size == "medium" ? .systemMedium : .systemSmall))
//                        .previewDisplayName("\(widget.size.capitalized) Widget")
//                }
//            }
//        }
//    }
//}
