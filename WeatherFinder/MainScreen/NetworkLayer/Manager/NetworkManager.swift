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
    func getWeatherImage(iconID: String, expression: @escaping (UIImage?, Error?) -> Void)
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
    
    func getWeatherImage(iconID: String, expression: @escaping (UIImage?, Error?) -> Void) //data.hashValue method
    {
        switch iconID {
            case "01d": imageRequest(type: ImagesEndpoint.clearSkyDay, expression: {(image, error) -> Void in
                do {
                        try expression(image,nil)
                }
                catch {}
            })
//            case "01n": ImagesEndpoint.clearSkyNight
//            case "02d": ImagesEndpoint.fewCloudsDay
//            case "02n": ImagesEndpoint.fewCloudsNight
//            case "03d": ImagesEndpoint.scatteredCloudsDay
//            case "03n": ImagesEndpoint.scatteredCloudsNight
//            case "04d": ImagesEndpoint.brokenClouds
//            case "04n": ImagesEndpoint.brokenCloudsNight
//            case "09d": ImagesEndpoint.showerRainDay
//            case "09n": ImagesEndpoint.showerRainNight
//            case "10d": ImagesEndpoint.rainDay
//            case "10n": ImagesEndpoint.rainNight
//            case "11d": ImagesEndpoint.thunderstormDay
//            case "11n": ImagesEndpoint.thunderstormNight
//            case "13d": ImagesEndpoint.snowDay
//            case "13n": ImagesEndpoint.snowNight
//            case "50d": ImagesEndpoint.mist
//            case "50n": ImagesEndpoint.mistNight
//        TODO other cases of image
        }
    }
    
    private func imageRequest(type: EndPointType, expression: @escaping (UIImage?, Error?) -> Void) {
        networkSevice.makeRequest(with: type, cachePolicy: .useProtocolCachePolicy, completion: {(dataImage, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        guard let imgData = dataImage else {
                            throw NetworkError.notFound
                        }
                        let image = UIImage(data: imgData)
                        expression(image, nil)
                        
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
