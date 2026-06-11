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
                withAnimation {
                    temperature = "25°C 🌡️"
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
