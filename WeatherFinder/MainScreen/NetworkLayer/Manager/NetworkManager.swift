//
//  NetworkManager.swift
//  WeatherFinder
//
//  Created by Romanovskiy Volodymyr on 15.10.2020.
//  Copyright © 2020 Romanovskiy Volodymyr. All rights reserved.
//

import Foundation
import UIKit

protocol NetManagerProtocol {
    func getWeatherDataByCityName(name: String, expression: @escaping (WeatherDataModel?, Error?) -> ())
    func getWeatherImage()
    func getWeatherByCoordinates(longitude: Double, latitude: Double)
}

class NetworkManager: NetManagerProtocol {
    
    // Singleton
    static let shared = NetworkManager()
    
    private let networkSevice = NetworkService()
    
    /* weather units should be updated in UserDefaults from somewhere else (for example,
    application settings menu controller class). Probably, a new Trello task with UserDefaults
    setup should be created */
    var weatherUnits: String {
        return UserDefaults.standard.string(forKey: "units") ?? "metric"
    }

    //One of Singleton conditions
    private init() {}
    
    func getWeatherDataByCityName(name: String, expression: @escaping (WeatherDataModel?, Error?) -> ()) {
        let decoder = JSONDecoder()
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name), completion: {  (data, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        if let dataInner = data {
                            let weather = try? decoder.decode(WeatherDataModel.self, from: dataInner)//TODO handle posible exception of decoding
                            expression(weather, nil)
                        }
                        else {
                            //maybe some logic that handling exception when data is nil
                        }
                    case 404: throw NetworkError.notFound
                        
                    case .none: expression(nil, error)
                        
                    case .some(_): expression(nil, nil) //TODO make logic for other status codes
                }
            }
            catch let error
            {
                expression(nil, error)
            }
        })
    }
    
    
    func getWeatherImage()
    {
        //TODO
    }
    
    
    func getWeatherByCoordinates(longitude: Double, latitude: Double) {
        <#code#>//TODO
    }
    
    /* TODO: add different kinds of methods performing requests like getWeatherByCityName(name:completion:),
    getWeatherImage(iconId:completion:) etc, parse all JSON data inside a model, and return this model inside
    Result enum (which contains success and failure cases) using escaping closure */
    
    //TODO: handle responses
    
    //TODO: perform internet connection check
    
    //TODO: handle various errors
    
    //TODO: handle caching images (NSCache)
    
}
