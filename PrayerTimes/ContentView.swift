//
//  ContentView.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 24.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State var days = [Day]()
    
    var body: some View {
        VStack {
            VStack{
                Text(days.first?.fajr ?? "Yes")
                Text(days.first?.sunrise ?? "No")
                Text(days.first?.dhuhr ?? "No")
                Text(days.first?.asr ?? "No")
                Text(days.first?.maghrib ?? "No")
                Text(days.first?.isha ?? "No")
                Button("Button") {
                    loadDays()
                }
            }
            .padding()
        }
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
