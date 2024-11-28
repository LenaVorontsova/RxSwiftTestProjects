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

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0, humidity: 0))
    }
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
