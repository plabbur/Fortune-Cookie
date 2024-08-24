//
//  WidgetConstants.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/23/24.
//

import Foundation
import SwiftUI

struct WidgetConstants {
    static let darkBlueGradient: LinearGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.847, green: 0.82, blue: 1.0), location: 0.00),
            Gradient.Stop(color: Color(red: 0.776, green: 0.741, blue: 1.0), location: 0.33),
            Gradient.Stop(color: Color(red: 0.42, green: 0.373, blue: 0.69), location: 0.66),
            Gradient.Stop(color: Color(red: 0.71, green: 0.686, blue: 0.847), location: 0.99)
        ],
        startPoint: UnitPoint(x: 0, y: 0),
        endPoint: UnitPoint(x: 1, y: 1)
    )
}
