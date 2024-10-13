//
//  WidgetConstants.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/23/24.
//

import Foundation
import SwiftUI

struct WidgetConstants {
    static let darkBlueGradient = LinearGradient(stops: [Gradient.Stop(color: .darkBlueGradientStart, location: 0.00), Gradient.Stop(color: .darkBlueGradientEnd, location: 1.0)], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
    
    static let defaultWidgetModelMedium = WidgetModelWidget(size: "medium", color: darkBlueGradient, font: "Times New Roman")
    static let defaultWidgetModelSmall = WidgetModelWidget(size: "small", color: darkBlueGradient, font: "Inter")

}
