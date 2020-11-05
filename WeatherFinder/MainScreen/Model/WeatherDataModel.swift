//
//  WeatherDataModel.swift
//  WeatherFinder
//
//  Created by User1 on 15.10.2020.
//  Copyright © 2020 Romanovskiy Volodymyr. All rights reserved.
//

import Foundation

struct WeatherDataModel: Decodable {
    var nameOfCity: String
    let weatherCondition: [Weather?]
    let mainWeatherInfo: Main?
    let windSpeed: WindSpeed?

    struct Weather: Decodable {
        let description: String
        let icon: String
    }

    enum CodingKeys: String, CodingKey {
        case nameOfCity = "name"
        case mainWeatherInfo = "main"
        case windSpeed = "wind"
        case weatherCondition = "weather"
    }
}

struct Main: Decodable {
    let temperature: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let temperatureMinimum: Double
    let temperatureMaximum: Double

    enum CodingKeys: String, CodingKey {
        case pressure, humidity
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMinimum = "temp_min"
        case temperatureMaximum = "temp_max"
    }
}

struct WindSpeed: Decodable {
    let speed: Float
}
