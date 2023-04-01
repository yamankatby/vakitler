//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 24.03.2023.
//

import SwiftUI

@main
struct PrayerTimesApp: App {
    var body: some Scene {
        MenuBarExtra("Prayer Times") {
            VStack {
                ContentView()
            }
            .colorScheme(.light)
        }
        .menuBarExtraStyle(.window)
    }
}
