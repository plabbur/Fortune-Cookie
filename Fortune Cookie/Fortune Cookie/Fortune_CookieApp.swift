//
//  Fortune_CookieApp.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import SwiftUI

@main
struct Fortune_CookieApp: App {
    @StateObject private var fortuneCookieModel = FortuneCookieModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(FortuneCookieModel())
        }
//        .widget {
//            Fortune_Cookie_Widget()
////                .environmentObject(fortuneCookieModel)
//        }
    }
}
