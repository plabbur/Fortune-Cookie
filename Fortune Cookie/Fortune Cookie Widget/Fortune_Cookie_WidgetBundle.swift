//
//  Fortune_Cookie_WidgetBundle.swift
//  Fortune Cookie Widget
//
//  Created by Cole Abrams on 8/21/24.
//

import WidgetKit
import SwiftUI

@main
struct Fortune_Cookie_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Fortune_Cookie_Widget()
        Fortune_Cookie_WidgetLiveActivity()
    }
}
