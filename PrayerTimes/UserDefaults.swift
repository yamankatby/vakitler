//
//  UserDefaults.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 30.03.2023.
//

import Foundation

extension UserDefaults {
    var days: [Day]? {
        get {
            if let data = data(forKey: "days"),
               let decodedData = try? JSONDecoder().decode([Day].self, from: data) {
                return decodedData
            } else {
                return nil
            }
        }
        set {
            if let newValue = newValue,
               let encodedValue = try? JSONEncoder().encode(newValue) {
                self.set(encodedValue, forKey: "days")
            } else {
                removeObject(forKey: "days")
            }
        }
    }
}
