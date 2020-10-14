//
//  WeatherDataModel.swift
//  WeatherFinder
//
//  Created by User1 on 05.10.2020.
//  Copyright © 2020 Romanovskiy Volodymyr. All rights reserved.
//

import Foundation

struct WeatherDataModel: Decodable{
    var nameOfCity: String
    let temperatureCelcium: Int?
    let feelsLike: Int?
    let weather: Array<Weather?>
           
    struct Weather: Decodable {
        let description: String
        let icon: String
    }
    
    enum CodingKeys: String, CodingKey {
        case nameOfCity = "name"
        case temperatureCelcium = "temp"
        case feelsLike = "feels_like"
        case weather
    }
}


