//
//  AppIntent.swift
//  Fortune Cookie Widget
//
//  Created by Cole Abrams on 8/21/24.
//

import WidgetKit
import AppIntents
import Fortune_Cookie

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
