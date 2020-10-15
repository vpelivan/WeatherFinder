//
//  WeatherApiEndpoint.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 14.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// can be extended with various API requests
enum WeatherApiEndpoint {
    case findCityByName(name: String)
    case findCityByCoordinates(lattitude: Double, longtitute: Double)
    case oneCallByCoordinates(lattitude: Double, longtitute: Double, exclude: String)
}

extension WeatherApiEndpoint: EndPointType {
    
    var baseURL: URL {
        let baseURLString = "https://api.openweathermap.org/data/2.5/"
        guard let url = URL(string: baseURLString) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .findCityByName, .findCityByCoordinates:
            return "weather"
        case .oneCallByCoordinates:
            return "onecall"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .findCityByName(let name):
            return .requestWithParameters(bodyParameters: nil,
                                          urlParameters: ["q": name,
                                                          "units": weatherUnits,
                                                          "appid": apiKey])
        case .findCityByCoordinates(let lattitude, let longtitute):
            return .requestWithParameters(bodyParameters: nil,
                                          urlParameters: ["lat": lattitude,
                                                          "lon": longtitute,
                                                          "units": weatherUnits,
                                                          "appid": apiKey])
        case .oneCallByCoordinates(let lattitude, let longtitute, let exclude):
            return .requestWithParameters(bodyParameters: nil,
                                          urlParameters: ["lat": lattitude,
                                                          "lon": longtitute,
                                                          "exclude": exclude,
                                                          "units": weatherUnits,
                                                          "appid": apiKey])
        }
    }
    
    // we don't use any addittional headers, that's why it's nil
    var headers: HTTPHeaders? {
        return nil
    }
    
    private var apiKey: String {
        return NetworkManager.shared.apiKey
    }
    
    private var weatherUnits: String {
        return NetworkManager.shared.weatherUnits
    }
}
