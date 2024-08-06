//
//  WidgetModel.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import Foundation
import SwiftUI

class WidgetModel: Identifiable, Equatable, Hashable {
    
    let id = UUID()

    var size: SizeMode
    var color: Color
    
    enum SizeMode {
        case SMALL
        case MEDIUM
    }
    
    init(size: SizeMode, color: Color) {
        self.size = size
        self.color = color
    }
    
    func getName() -> String {
        return getSizeAsString().localizedCapitalized + " " + getColorAsHex(color: color).uppercased()
    }
    
    func getNameFromColor(color: Color) -> String {
        return getSizeAsString().localizedCapitalized + " " + getColorAsHex(color: color).uppercased()
    }
    
    func getSize() -> SizeMode {
        return size
    }
    
    func getSizeAsString() -> String {
        if size == SizeMode.SMALL {
            return "small"
        } else {
            return "medium"
        }
    }
    
    func getColor() -> Color {
        return color
    }
    
    func getColorAsHex(color: Color) -> String {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let redHex = String(format: "%02X", Int(red * 255))
        let greenHex = String(format: "%02X", Int(green * 255))
        let blueHex = String(format: "%02X", Int(blue * 255))
        let alphaHex = String(format: "%02X", Int(alpha * 255))
        
        let hexString = "#\(redHex)\(greenHex)\(blueHex)"

        return hexString
    }
    
//    func getGradient(color: Color) -> Gradient {
//        return Gradient()
//    }
    
    func displayWidget(staged: Bool) -> WidgetView {
        return WidgetView(staged: staged, size: size, color: color)
    }
    
    static func == (lhs: WidgetModel, rhs: WidgetModel) -> Bool {
        return lhs.size == rhs.size && lhs.color == rhs.color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
}
