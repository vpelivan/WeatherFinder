//
//  NetworkManager.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 15.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    // Singleton
    static let shared = NetworkManager()
    
    // external dependencies
    private let networkSevice = NetworkService()
    
    // variables
    let apiKey = "bca99eeb8ff098c732b8104e606a8190"
    
    // weather units might be computed
    let weatherUnits = "metric"
    
    //One of Singleton conditions
    private init() {}
    
    /* TODO: add different kinds of methods performing requests like getWeatherByCityName(name:completion:),
    getWeatherImage(iconId:completion:) etc, parse all JSON data inside a model, and return this model inside
    Result enum (which contains success and failure cases) using escaping closure */
    
    //TODO: handle responses
    
    //TODO: perform internet connection check
    
    //TODO: handle various errors
}
