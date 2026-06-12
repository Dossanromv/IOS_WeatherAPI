//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rakhat Dossanbayev on 09.06.2026.
//
import Foundation
import Combine
import SwiftUI



struct WeatherResponse: Codable {
    let current_weather: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}


struct ContentView: View {
    
    
    @State private var temperature = "—"
    @State private var windspeed = "—"
    @State private var cityName = "City"
    @State private var latitude = 42.3
    @State private var longitude = 69.6
    @State private var weatherEmoji = "🌤️"
    @State private var bgColors: [Color] = [.blue, .cyan]

    
    
    func weatherIcon(_ code: Int) -> String {
        switch code {
        case 0: return "☀️"
        case 1, 2, 3: return "⛅️"
        case 61, 63, 65: return "🌧️"
        case 71, 73, 75: return "❄️"
        case 95: return "⛈️"
        default: return "🌤️"
        }
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: bgColors,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("🌍 Weather")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Picker("The City", selection: $cityName) {
                    Text("Shymkent").tag("Shymkent")
                    Text("Almaty").tag("Almaty")
                    Text("Astana").tag("Astana")
                }
                
                
                .pickerStyle(.segmented)
                .onChange(of: cityName) { city in
                    switch city {
                    case "Almaty":
                        latitude = 43.25
                        longitude = 76.95
                    case "Astana":
                        latitude = 51.18
                        longitude = 71.45
                    default:
                        latitude = 42.3
                        longitude = 69.6
                    }
                }
                
                
                
                
                Text(weatherEmoji)
                    .font(.system(size: 80))

                Text(cityName)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                
                Text(temperature)
                    .foregroundColor(.white)

                    .font(.system(size:60))
                
                Button("find out") {
                    
                    
                    
                    Task {
                        
                        
                        
                        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true")!
                        
                        
                        let (data, _) = try await URLSession.shared.data(from: url)
                        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        

                        
                        withAnimation {
                            
                                    temperature = "\(weather.current_weather.temperature)°C"
                            weatherEmoji = weatherIcon(weather.current_weather.weathercode)
                            
                            withAnimation(.easeInOut(duration: 1.0)) {
                                switch weather.current_weather.weathercode {
                                case 0: bgColors = [.orange, .yellow]      // ☀️ ясно
                                case 1, 2, 3: bgColors = [.blue, .cyan]    // ⛅️ облачно
                                case 61, 63, 65: bgColors = [.gray, .blue] // 🌧️ дождь
                                case 71, 73, 75: bgColors = [.white, .gray]// ❄️ снег
                                case 95: bgColors = [.black, .gray]        // ⛈️ гроза
                                default: bgColors = [.blue, .cyan]
                                }
                            }

                            
                                }
                        


                    }

                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
