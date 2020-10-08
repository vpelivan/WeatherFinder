//
//  WeatherDataModel.swift
//  WeatherFinder
//
//  Created by User1 on 05.10.2020.
//  Copyright © 2020 Romanovskyi Volodymyr. All rights reserved.
//

import Foundation

struct WeatherDataModelJSON:Decodable {
     var name: String? 
     var temp: Int?
     var feels_like: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case nameOFCity
//        case temperatureCelcium
//        case feelsLike
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        nameOFCity = try container.decode(String.self, forKey: .nameOFCity)
//        temperatureCelcium = try container.decode(Int.self, forKey: .temperatureCelcium)
//        feelsLike = try container.decode(Int.self, forKey: .feelsLike)
//    }
}
