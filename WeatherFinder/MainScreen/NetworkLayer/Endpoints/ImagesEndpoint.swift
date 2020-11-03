//
//  ImagesEndpoint.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 15.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

enum ImagesEndpoint: String {
    case clearSkyDay
    case clearSkyNight
    case fewCloudsDay
    case fewCloudsNight
    case scatteredCloudsDay
    case scatteredCloudsNight
    case brokenClouds
    case brokenCloudsNight
    case showerRainDay
    case showerRainNight
    case rainDay
    case rainNight
    case thunderstormDay
    case thunderstormNight
    case snowDay
    case snowNight
    case mist
    case mistNight
}

extension ImagesEndpoint: EndPointType {

    var baseURL: URL {
        let baseURLString: String
        switch self {
        case .mist:
            baseURLString = "https://icons.iconarchive.com/icons/icons-land/weather/256"
        default:
            baseURLString = "https://icons.iconarchive.com/icons/oxygen-icons.org/oxygen/256/"
        }
        guard let url = URL(string: baseURLString) else { fatalError("baseURL could not be configured") }
        return url
    }

    var path: String {
        switch self {
        case .clearSkyDay: return "Status-weather-clear-icon.png"
        case .clearSkyNight: return "Status-weather-clear-night-icon.png"
        case .fewCloudsDay: return "Status-weather-few-clouds-icon.png"
        case .fewCloudsNight: return "Status-weather-few-clouds-night-icon.png"
        case .scatteredCloudsDay: return "Status-weather-clouds-icon.png"
        case .scatteredCloudsNight: return "Status-weather-clouds-night-icon.png"
        case .brokenClouds, .brokenCloudsNight: return "Status-weather-many-clouds-icon.png"
        case .showerRainDay: return "Status-weather-showers-day-icon.png"
        case .showerRainNight: return "Status-weather-showers-night-icon.png"
        case .rainDay: return "Status-weather-showers-scattered-day-icon.png"
        case .rainNight: return "Status-weather-showers-scattered-night-icon.png"
        case .thunderstormDay: return "Status-weather-storm-day-icon.png"
        case .thunderstormNight: return "Status-weather-storm-night-icon.png"
        case .snowDay: return "Status-weather-snow-scattered-day-icon.png"
        case .snowNight: return "Status-weather-snow-scattered-night-icon.png"
        case .mist, .mistNight: return "Fog-icon.png"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return .getRequest
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
