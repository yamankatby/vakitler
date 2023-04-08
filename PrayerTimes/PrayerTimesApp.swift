//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by Yaman Katby on 24.03.2023.
//

import SwiftUI
import ServiceManagement

let launcherAppId = "yaman.PrayerTimes"

struct GeneralSettingsView: View {
    @AppStorage("showPreview") private var showPreview = true
    @AppStorage("fontSize") private var fontSize = 12.0
    
    @State var countries = [Country]()
    @State var country: Country? {
        didSet {
            regions = nil
            region = nil
            
            if let country = country {
                loadRegions(countryId: country.id)
            }
        }
    }
    
    @State var regions: [Region]?
    @State var region: Region? {
        didSet {
            cities = nil
            city = nil
            
            if let region = region {
                loadCities(regionId: region.id)
            }
        }
    }
    
    @State var cities: [City]?
    @State var city: City?
    
    func loadCountries() {
        let url = getCountriesUrl()
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = try? JSONDecoder().decode([Country].self, from: data) {
                DispatchQueue.main.async {
                    self.countries = response
                }
            }
        }.resume()
    }
    
      func loadRegions(countryId: String) {
          let url = getRegionsUrl(countryId: countryId)
          let request = URLRequest(url: url)
          
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let data = data, let response = try? JSONDecoder().decode([Region].self, from: data) {
                  DispatchQueue.main.async {
                      self.regions = response
                  }
              }
          }.resume()
      }
      
      func loadCities(regionId: String) {
          let url = getCitiesUrl(regionId: regionId)
          let request = URLRequest(url: url)
          
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let data = data, let response = try? JSONDecoder().decode([City].self, from: data) {
                  DispatchQueue.main.async {
                      self.cities = response
                  }
              }
          }.resume()
      }

        
    var body: some View {
        Form {
            Button("True") {
                let s = SMAppService.loginItem(identifier: launcherAppId)
                do {
                    try s.register()
                } catch {
                    
                }
            }
            
            Menu {
                ForEach(countries) { country in Button(action: { self.country = country }, label: { Text(country.name) }) }
            } label: { Text(self.country?.name ?? "Select") }
            
            if let regions = regions {
                Menu {
                    ForEach(regions) { region in Button(action: { self.region = region }, label: { Text(region.name) }) }
                } label: { Text(self.region?.name ?? "Select") }
            }
            
            if let cities = cities {
                Menu {
                    ForEach(cities) { city in Button(action: { self.city = city }, label: { Text(city.name) }) }
                } label: { Text(self.city?.name ?? "Select") }
            }
            
        }
        .padding(20)
        .frame(width: 350, height: 100)
        .onAppear(perform: loadCountries)
    }
}


struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }
                .tag(Tabs.general)
            
            GeneralSettingsView()
                .tabItem {
                    Label("Location", systemImage: "location")
                }
            
            GeneralSettingsView()
                .tabItem {
                    Label("Adjustments", systemImage: "slider.horizontal.3")
                }
            
            GeneralSettingsView()
                .tabItem {
                    Label("About", systemImage: "questionmark.circle")
                }
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}

@main
struct PrayerTimesApp: App {
    var body: some Scene {
        MenuBarExtra("P") {
            VStack {
                ContentView()
            }
            .colorScheme(.light)
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            SettingsView()
        }
    }
}
