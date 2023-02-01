//
//  WeatherData.swift
//  Clima
//
//  Created by Eser Lodhia on 01/10/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {     //weather[0].description, weather[0].id
    let description: String
    let id: Int
}

struct Wind: Codable { // wind
    let speed: Double
}
