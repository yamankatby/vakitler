//
//  ContentView.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 24.03.2023.
//

import SwiftUI

struct TimeCell: View {
    var label: String
    
    var date: Date?
    
    var color: Color
    
    var formattedDate: String {
        guard let date = date else {
            return "No"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter.string(from: date)
    }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(formattedDate)
        }
        .padding(20)
        .background(color)
    }
}

struct ContentView: View {
    @State var days = UserDefaults.standard.days ?? [Day]()
    
    var today: Day? {
        return days.first(where: { Calendar.current.isDateInToday($0.date) })
    }
    
    func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return "No"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter.string(from: date)
    }
    
    let now = Date()
    
    var prayerTime: PrayerTime {
        if let isha = today?.isha, isha >= now {
            return .isha
        } else if let maghrib = today?.maghrib, maghrib >= now {
            return .maghrib
        } else if let asr = today?.asr, asr >= now {
            return .asr
        } else if let dhuhur = today?.dhuhr, dhuhur >= now {
            return .dhuhr
        } else if let sunrise = today?.sunrise, sunrise >= now {
            return .sunrise
        } else if let fajr = today?.fajr, fajr >= now {
            return .fajr
        }
        return .dhuhr
    }
    
    var palette: Palette {
        switch prayerTime {
        case .fajr: return Color.blue
        case .sunrise: return Color.sky
        case .dhuhr: return Color.orange
        case .asr: return Color.yellow
        case .maghrib: return Color.rose
        case .isha: return Color.indigo
        }
    }
    
    var nextTime: Date? {
        switch prayerTime {
        case .fajr: return today?.fajr
        case .sunrise: return today?.sunrise
        case .dhuhr: return today?.dhuhr
        case .asr: return today?.asr
        case .maghrib: return today?.maghrib
        case .isha: return today?.isha
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(nextTime!, style: .relative)
                Spacer()
            }
            .frame(height: 140)
            .background(palette._50)
            TimeCell(label: "Fajr", date: today?.fajr, color: palette._100)
            TimeCell(label: "Sunrise", date: today?.sunrise, color: palette._200)
            TimeCell(label: "Dhuhr", date: today?.dhuhr, color: palette._300)
            TimeCell(label: "Asr", date: today?.asr, color: palette._400)
            TimeCell(label: "Maghrib", date: today?.maghrib, color: palette._500)
            TimeCell(label: "Isha", date: today?.isha, color: palette._600)
        }
        .onAppear(perform: loadDays)
    }
    
    func loadDays() {
        guard let url = URL(string: "https://vakitler.vercel.app/api/times?cityID=17893") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Day].self, from: data) {
                    DispatchQueue.main.async {
                        self.days = response
                        UserDefaults.standard.days = response
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
