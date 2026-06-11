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
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}



struct ContentView: View {
    
    @State private var temperature = "_"
    
    
    var body: some View {
        Text("Погода загружается...")

        VStack {
            Text("🌤 Shymkent")
                .font(.largeTitle)
                .bold()
            Text(temperature)
                .font(.system(size:60))
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
