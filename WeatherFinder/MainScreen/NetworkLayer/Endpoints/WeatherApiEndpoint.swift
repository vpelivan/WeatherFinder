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
        let baseURLString = Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String
        guard let baseURLStringNonNil = baseURLString,
              let url = URL(string: baseURLStringNonNil) else {
            fatalError("baseURL could not be configured")
        }
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
            return .getRequestWithParameters(urlParameters: ["q": name,
                                                             "units": weatherUnits,
                                                             "appid": apiKey])
        case .findCityByCoordinates(let lattitude, let longtitute):
            return .getRequestWithParameters(urlParameters: ["lat": lattitude,
                                                             "lon": longtitute,
                                                             "units": weatherUnits,
                                                             "appid": apiKey])
        case .oneCallByCoordinates(let lattitude, let longtitute, let exclude):
            return .getRequestWithParameters(urlParameters: ["lat": lattitude,
                                                             "lon": longtitute,
                                                             "exclude": exclude,
                                                             "units": weatherUnits,
                                                             "appid": apiKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type" : "application/json"]
    }
    
    private var apiKey: String {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String
        guard let apiKeyNonNil = apiKey else {
            fatalError("apiKey could not be found in info.plist")
        }
        return apiKeyNonNil
    }
    
    private var weatherUnits: String {
        return NetworkManager.shared.weatherUnits
    }
}
