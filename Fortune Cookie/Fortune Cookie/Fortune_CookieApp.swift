//
//  Fortune_CookieApp.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import SwiftUI

@main
struct Fortune_CookieApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(FortuneCookieModel())
        }
    }
}
