//
//  Day.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 30.03.2023.
//

import Foundation

struct Day: Codable {
    private let fajrString: String
    private let sunriseString: String
    private let dhuhrString: String
    private let asrString: String
    private let maghribString: String
    private let ishaString: String
    private let dateString: String
    
    enum CodingKeys: String, CodingKey {
        case fajrString = "Imsak"
        case sunriseString = "Gunes"
        case dhuhrString = "Ogle"
        case asrString = "Ikindi"
        case maghribString = "Aksam"
        case ishaString = "Yatsi"
        case dateString = "MiladiTarihKisa"
    }
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: dateString)!
    }
    
    var fajr: Date { combineDate(with: fajrString) }
    
    var sunrise: Date { combineDate(with: sunriseString) }
    
    var dhuhr: Date { combineDate(with: dhuhrString) }
    
    var asr: Date { combineDate(with: asrString) }
    
    var maghrib: Date { combineDate(with: maghribString) }
    
    var isha: Date { combineDate(with: ishaString) }
    
    func combineDate(with: String) -> Date {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let time = timeFormatter.date(from: with)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        let combinedDate = calendar.date(bySettingHour: components.hour ?? 0, minute: components.minute ?? 0, second: 0, of: date)!
        
        return combinedDate
    }
}
