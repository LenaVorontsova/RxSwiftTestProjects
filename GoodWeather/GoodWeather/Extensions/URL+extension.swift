//
//  URL+extension.swift
//  GoodWeather
//
//  Created by Елена Воронцова on 28.11.2024.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=bc23d31aad9d0f4f1e29a06136594d22&units=imperial")
    }
}
