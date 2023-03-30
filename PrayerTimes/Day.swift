//
//  Day.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 30.03.2023.
//

import Foundation

struct Day: Codable {
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
    
    enum CodingKeys: String, CodingKey {
        case fajr = "Imsak"
        case sunrise = "Gunes"
        case dhuhr = "Ogle"
        case asr = "Ikindi"
        case maghrib = "Aksam"
        case isha = "Yatsi"
    }
}
