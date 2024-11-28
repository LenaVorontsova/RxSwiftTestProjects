//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by Елена Воронцова on 28.11.2024.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
