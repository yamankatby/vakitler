//
//  ContentView.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 24.03.2023.
//

import SwiftUI

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
                Text(formatDate(today?.fajr))
                Text(formatDate(today?.sunrise))
                Text(formatDate(today?.dhuhr))
                Text(formatDate(today?.asr))
                Text(formatDate(today?.maghrib))
                Text(formatDate(today?.isha))
            }
            .padding()
        }
        .onAppear(perform: loadDays)
        .background(Color.purple)
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
