//
//  WidgetColor.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/25/24.
//

import Foundation
import SwiftUI

public class WidgetColor: Identifiable, Equatable, Hashable {
    
    var gradientStart: Color
    var gradientEnd: Color
    
    init(gradientStart: Color, gradientEnd: Color) {
        self.gradientStart = gradientStart
        self.gradientEnd = gradientEnd
    }
    
    public func getStart() -> Color {
        return self.gradientStart
    }
    
    public func getEnd() -> Color {
        return self.gradientEnd
    }
    
    public func getGradient() -> LinearGradient {
        return LinearGradient(stops: [Gradient.Stop(color: gradientStart, location: 0.00), Gradient.Stop(color: gradientEnd, location: 1.0)], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
    }
    
    public func editGradientStart(gradientStart: Color) {
        self.gradientStart = gradientStart
    }
    
    public func editGradientEnd(gradientEnd: Color) {
        self.gradientEnd = gradientEnd
    }
    
    public static func == (lhs: WidgetColor, rhs: WidgetColor) -> Bool {
        return lhs.gradientStart == rhs.gradientStart && lhs.gradientEnd == rhs.gradientEnd
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
}
