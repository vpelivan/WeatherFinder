//
//  WeatherDataModel.swift
//  WeatherFinder
//
//  Created by User1 on 05.10.2020.
//  Copyright © 2020 Romanovskiy Volodymyr. All rights reserved.
//

import Foundation

struct WeaterDataModel: Decodable{
    let nameOFCity: String
    let temperatureCelcium: Int
    var feelsLike: Int
    var description: String?
    let weather:[Weather]?
    
    struct Weather: Decodable {
        let description: String
        let ico: String
        //let id:Int
        //let main: String
    }
    
    enum CodingKeys: String, CodingKey {
        case nameOFCity = "name"
        case temperatureCelcium = "temp"
        case feelsLike = "feels_like"
        case description
        case weather
    }
    
    mutating func setdes() -> String {
        let weather1 = weather!
        description = weather1[0].description
        return description!
    }
}
