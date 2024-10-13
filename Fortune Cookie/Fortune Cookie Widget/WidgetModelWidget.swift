//
//  WidgetModelWidget.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/29/24.
//

import Foundation
import SwiftUI

public class WidgetModelWidget: Identifiable, Equatable, Hashable {
    
    public let id = UUID()

    var size: String
    var color: LinearGradient
    var font: String
    
    init(size: String, color: LinearGradient, font: String) {
        self.size = size
        self.color = color
        self.font = font
    }

    func getFont() -> String {
        return font
    }
    
    func getSize() -> String {
        return size
    }
    
    func getColor() -> LinearGradient {
        return color
    }
    
    public static func == (lhs: WidgetModelWidget, rhs: WidgetModelWidget) -> Bool {
        return lhs.size == rhs.size && lhs.font == rhs.font
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
}
