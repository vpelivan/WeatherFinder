//
//  WeatherDataModel.swift
//  WeatherFinder
//
//  Created by User1 on 15.10.2020.
//  Copyright © 2020 Romanovskiy Volodymyr. All rights reserved.
//

import Foundation

struct WeatherDataModel: Decodable{
    var nameOfCity: String
    let weatherCondition: [Weather?]
    let mainWeatherInfo: Main?adfg
    let windSpeed: windSpeed?
    
    
    struct Main: Decodable {
        let temperature: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let temperatureMinimal: Double
        let temperatureMaximum: Double
        
        enum CodingKeysMain: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
            case pressure
            case humidity
            case temperatureMinimal = "temp_min"
            case temperarureMaximum = "temp_max"
        }
    }
    
    struct Weather: Decodable {
        let description: String
        let icon: String
    }
    
    struct windSpeed: Decodable {
        let speed: Float
    }
    
    enum CodingKeys: String, CodingKey {
        case nameOfCity = "name"
        case mainWeatherInfo = "main"
        case windSpeed = "wind"
        case weatherCondition = "weather"
    }
}
