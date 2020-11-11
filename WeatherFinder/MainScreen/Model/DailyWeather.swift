//
//  DailyWeather.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 04.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

struct DailyWeather: Decodable {
    let oneWeekWeather: [OneDayWeather]
    enum CodingKeys: String, CodingKey {
        case oneWeekWeather = "daily"
    }
}

struct OneDayWeather: Decodable {
    let dateAndTime: Date
    let pressure, humidity: Int
    let windSpeed: Double
    let temperature: OneDayTemperature?
    let feelsLike: OneDayTemperature?
    let weatherCondition: [Weather?]
    enum CodingKeys: String, CodingKey {
        case pressure, humidity
        case dateAndTime = "dt"
        case windSpeed = "wind_speed"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case weatherCondition = "weather"
    }
}

struct OneDayTemperature: Decodable {
    let dayTemperature, nightTemperature, eveningTemperature, morningTemperature: Double
    let minimumTemperature, maximumTemperature: Double?
    enum CodingKeys: String, CodingKey {
        case dayTemperature = "day"
        case nightTemperature = "night"
        case minimumTemperature = "min"
        case maximumTemperature = "max"
        case eveningTemperature = "eve"
        case morningTemperature = "morn"
    }
}
