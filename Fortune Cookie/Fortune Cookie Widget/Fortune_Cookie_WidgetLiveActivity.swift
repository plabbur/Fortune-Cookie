//
//  Fortune_Cookie_WidgetLiveActivity.swift
//  Fortune Cookie Widget
//
//  Created by Cole Abrams on 8/21/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Fortune_Cookie_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Fortune_Cookie_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Fortune_Cookie_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Fortune_Cookie_WidgetAttributes {
    fileprivate static var preview: Fortune_Cookie_WidgetAttributes {
        Fortune_Cookie_WidgetAttributes(name: "World")
    }
}

extension Fortune_Cookie_WidgetAttributes.ContentState {
    fileprivate static var smiley: Fortune_Cookie_WidgetAttributes.ContentState {
        Fortune_Cookie_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Fortune_Cookie_WidgetAttributes.ContentState {
         Fortune_Cookie_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Fortune_Cookie_WidgetAttributes.preview) {
   Fortune_Cookie_WidgetLiveActivity()
} contentStates: {
    Fortune_Cookie_WidgetAttributes.ContentState.smiley
    Fortune_Cookie_WidgetAttributes.ContentState.starEyes
}
