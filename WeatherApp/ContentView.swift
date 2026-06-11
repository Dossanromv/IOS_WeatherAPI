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
}


struct ContentView: View {
    
    @State private var temperature = "_"
    
    
    var body: some View {
        
        VStack {
            Text("🌤 Shymkent")
                .font(.largeTitle)
                .bold()
            
            Text(temperature)
                .font(.system(size:60))
            
            Button("find out") {
                
                
                
                Task {
                    
                    let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=42.3&longitude=69.6&current_weather=true")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

                    
                    withAnimation {
                                temperature = "\(weather.current_weather.temperature)°C"
                            }


                }
                
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
