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
            HStack {
                Text(label)
                Spacer()
                Text(formattedDate)
            }
            .padding(16)
        }
        .frame(width: 240)
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
    
    var body: some View {
        VStack {
            VStack{
                TimeCell(label: "Fajr", date: today?.fajr, color: Color.orange100)
                TimeCell(label: "Sunrise", date: today?.sunrise, color: Color.orange200)
                TimeCell(label: "Dhuhr", date: today?.dhuhr, color: Color.orange300)
                TimeCell(label: "Asr", date: today?.asr, color: Color.orange400)
                TimeCell(label: "Maghrib", date: today?.maghrib, color: Color.orange500)
                TimeCell(label: "Isha", date: today?.isha, color: Color.orange600)
            }
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
