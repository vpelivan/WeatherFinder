//
//  DailyWeather.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 04.11.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

struct DailyWeather: Decodable {
    let oneWeekWeather: [OneDayWeather?]
    enum CodingKeys: String, CodingKey {
        case oneWeekWeather = "daily"
    }
}

struct OneDayWeather: Decodable {
    let dateTimestamp: Double
    let temperature: OneDayTemperature?
    let weatherCondition: [Weather?]
    enum CodingKeys: String, CodingKey {
        case dateTimestamp = "dt"
        case temperature = "temp"
        case weatherCondition = "weather"
    }
}

struct OneDayTemperature: Decodable {
    let dayTemperature: Double
    enum CodingKeys: String, CodingKey {
        case dayTemperature = "day"
    }
}
