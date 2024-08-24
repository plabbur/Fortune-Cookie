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
        SimpleEntry(date: Date(), color: loadColor(), gradient: loadGradient(), font: loadFont(), fortune: loadFortune())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), color: loadColor(), gradient: loadGradient(), font: loadFont(), fortune: loadFortune())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), color: loadColor(), gradient: loadGradient(), font: loadFont(), fortune: loadFortune())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func loadFortune() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        return sharedDefaults?.string(forKey: "WidgetFortune") ?? ""
    }
    
    private func loadFont() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        return sharedDefaults?.string(forKey: "WidgetFont") ?? ""
    }

    private func loadColor() -> UIColor {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        if let colorData = sharedDefaults?.data(forKey: "WidgetColor"),
               let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                return color
            }
            
            return UIColor()
    }
    
    private func loadGradient() -> LinearGradient {
        let sharedDefaults = UserDefaults(suiteName: "group.com.coleabrams.Fortune-Cookie")
        
        
        switch sharedDefaults?.string(forKey: "WidgetColor") {
        case "darkBlue" :
            return WidgetConstants.darkBlueGradient
        default:
            return WidgetConstants.darkBlueGradient
        }
    }
    
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let color: UIColor
    let gradient: LinearGradient
    let font: String
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
        
        RoundedRectangle(cornerRadius: 17)
            .fill(Color(entry.color))
//                .scaleEffect(entry.size == "Small" ? 1.18 : 1.1)
            .scaleEffect(x: 1.18, y: 1.18)
//                .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.blue, lineWidth: 2)
//                    )
            .overlay {
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
}

struct Fortune_Cookie_WidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
//    var size: String

    var body: some View {
        
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
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
            
//            Fortune_Cookie_WidgetEntryView(entry: entry)
//                .containerBackground(.clear, for: .widget)

            RoundedRectangle(cornerRadius: 17)
                .fill(Color(entry.color))
//                .scaleEffect(entry.size == "Small" ? 1.18 : 1.1)
                .scaleEffect(x: self.family == .systemSmall ? 1.18 : 1.075, y: 1.18)
//                .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.blue, lineWidth: 2)
//                    )
                .overlay {
                    Fortune_Cookie_WidgetEntryView(entry: entry)
                        .containerBackground(entry.gradient, for: .widget)
                }
//                

//            if #available(iOS 17.0, *) {
//                Fortune_Cookie_WidgetEntryView(entry: entry)
////                    .background()
//
//                    .containerBackground(.fill.tertiary, for: .widget)
//            } else {
//                Fortune_Cookie_WidgetEntryView(entry: entry)
////                    .padding()
//                    .background()
//            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    Fortune_Cookie_Widget()
} timeline: {
    SimpleEntry(date: Date(), color: UIColor(.darkBlue), gradient: WidgetConstants.darkBlueGradient, font: "Times New Roman", fortune: "Fortune will find you soon, just wait")
}
