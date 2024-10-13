//
//  Constants.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import Foundation
import SwiftUI

struct Constants {
    // Colors
    static let offWhite: Color = Color(red: 0.93, green: 0.93, blue: 0.93)
    static let grayButtonBg: Color = Color(red: 0.23, green: 0.23, blue: 0.23)
    
    static let fonts: [String] = ["Times New Roman", "Inter", "Georgia", "Roboto", "Helvetica"]
    
    static let originalColors: [WidgetColor] = [
        WidgetColor(gradientStart: .blackGradientStart, gradientEnd: .blackGradientEnd),
        WidgetColor(gradientStart: .lightBlueGradientStart, gradientEnd: .lightBlueGradientEnd),
        WidgetColor(gradientStart: .darkBlueGradientStart, gradientEnd: .darkBlueGradientEnd),
        WidgetColor(gradientStart: .purpleGradientStart, gradientEnd: .purpleGradientEnd),
        WidgetColor(gradientStart: .lightPinkGradientStart, gradientEnd: .lightPinkGradientEnd),
        WidgetColor(gradientStart: .darkPinkGradientStart, gradientEnd: .darkPinkGradientEnd),
        WidgetColor(gradientStart: .darkRedGradientStart, gradientEnd: .darkRedGradientEnd),
        WidgetColor(gradientStart: .lightRedGradientStart, gradientEnd: .lightRedGradientEnd),
        WidgetColor(gradientStart: .orangeGradientStart, gradientEnd: .orangeGradientEnd),
        WidgetColor(gradientStart: .yellowGradientStart, gradientEnd: .yellowGradientEnd),
        WidgetColor(gradientStart: .lightGreenGradientStart, gradientEnd: .lightGreenGradientEnd),
        WidgetColor(gradientStart: .darkGreenGradientStart, gradientEnd: .darkGreenGradientEnd)
    ]
    
    static let menuOptionBorder: LinearGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(.menuOptionStroke), location: 0.00),
        ], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)
    )
    static let premiumGradient: LinearGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 1.0, green: 1.0, blue: 1.0), location: 0.00),
            Gradient.Stop(color: Color(red: 0.192, green: 0.929, blue: 0.71), location: 0.33),
            Gradient.Stop(color: Color(red: 0.404, green: 0.714, blue: 1.0), location: 0.66),
            Gradient.Stop(color: Color(red: 0.298, green: 1.0, blue: 0.537), location: 0.99)
        ], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)
    )
//    
//    static let darkBlueGradientTwo: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(.darkBlue), location: 0.00),
//        Gradient.Stop(color: Color(.darkBlueGradientEnd), location: 1.00),
//    ],
//    startPoint: UnitPoint(x: 0, y: 0),
//    endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let darkBlueGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 0.847, green: 0.82, blue: 1.0), location: 0.00),
//            Gradient.Stop(color: Color(red: 0.776, green: 0.741, blue: 1.0), location: 0.33),
//            Gradient.Stop(color: Color(red: 0.42, green: 0.373, blue: 0.69), location: 0.66),
//            Gradient.Stop(color: Color(red: 0.71, green: 0.686, blue: 0.847), location: 0.99)
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let lightRedGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 1.0, green: 0.192, blue: 0.192), location: 0.00),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.475, blue: 0.475), location: 0.50),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.0, blue: 0.0), location: 0.99),
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let lightYellowGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 0.984, green: 1.0, blue: 0.82), location: 0.00),
//            Gradient.Stop(color: Color(red: 0.902, green: 1.0, blue: 0.741), location: 0.33),
//            Gradient.Stop(color: Color(red: 0.522, green: 0.816, blue: 0.227), location: 0.66),
//            Gradient.Stop(color: Color(red: 0.212, green: 0.4, blue: 0.094), location: 0.99),
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let darkPinkGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 1.0, green: 0.475, blue: 0.918), location: 0.00),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.0, blue: 0.722), location: 0.50),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.671, blue: 0.969), location: 0.99),
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let goldGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 0.651, green: 0.408, blue: 0.122), location: 0.00),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.694, blue: 0.475), location: 0.50),
//            Gradient.Stop(color: Color(red: 0.651, green: 0.353, blue: 0.0), location: 0.99),
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let lightTealGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 0.435, green: 0.553, blue: 0.553), location: 0.00),
//            Gradient.Stop(color: Color(red: 0.29, green: 0.804, blue: 0.773), location: 0.33),
//            Gradient.Stop(color: Color(red: 0.373, green: 0.616, blue: 0.69), location: 0.66),
//            Gradient.Stop(color: Color(red: 0.686, green: 0.827, blue: 0.847), location: 0.99)
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    static let lightPinkGradient: LinearGradient = LinearGradient(
//        stops: [
//            Gradient.Stop(color: Color(red: 1.0, green: 0.671, blue: 0.969), location: 0.00),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.475, blue: 0.918), location: 0.50),
//            Gradient.Stop(color: Color(red: 1.0, green: 0.0, blue: 0.722), location: 0.99)
//        ],
//        startPoint: UnitPoint(x: 0, y: 0),
//        endPoint: UnitPoint(x: 1, y: 1)
//    )
//    
//    
//    
//    
//    
//
//                                                                         

    
    // Fonts
//    static let fontPrimary: Font = Font(Inter)
}
