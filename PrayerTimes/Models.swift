//
//  Models.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 8.04.2023.
//

import Foundation

struct Country: Codable, Identifiable {
    let id: String
    let name: String
    let nameEn: String

    enum CodingKeys: String, CodingKey {
        case id = "UlkeID"
        case name = "UlkeAdi"
        case nameEn = "UlkeAdiEn"
    }
}

struct Region: Codable, Identifiable {
    let id: String
    let name: String
    let nameEn: String
    
    enum CodingKeys: String, CodingKey {
        case id = "SehirID"
        case name = "SehirAdi"
        case nameEn = "SehirAdiEn"
    }
}

struct City: Codable, Identifiable {
    let id: String
    let name: String
    let nameEn: String
    
    enum CodingKeys: String, CodingKey {
        case id = "IlceID"
        case name = "IlceAdi"
        case nameEn = "IlceAdiEn"
    }
}
