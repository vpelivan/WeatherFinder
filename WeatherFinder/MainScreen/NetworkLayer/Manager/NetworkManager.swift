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
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (WeatherDataModel?, Error?) -> ())
    func getWeatherImage(iconID: String, completionHandler: @escaping (UIImage?) -> Void)
    func getWeatherByCoordinates(coords: Coordinates, completionHandler: @escaping (WeatherDataModel?, Error?) -> ())
}

struct Coordinates {
    var longitude: Double
    var latitude: Double
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
    
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (WeatherDataModel?, Error?) -> ()) {
        let decoder = JSONDecoder()
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name), completion: {  (data, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        if let dataInner = data {
                            let weather = try? decoder.decode(WeatherDataModel.self, from: dataInner)//TODO handle posible exception of decoding
                            completionHandler(weather, nil)
                        }
                        else {
                            //maybe some logic that handling exception when data is nil
                        }
                    case 404: throw NetworkError.notFound
                    case .none: completionHandler(nil, error)
                    case .some(_): completionHandler(nil, nil) //TODO make logic for other status codes
                }
            }
            catch let error
            {
                completionHandler(nil, error)
            }
        })
    }
    
    func getWeatherImage(iconID: String, completionHandler: @escaping (UIImage?) -> Void) //data.hashValue method
    {
        switch iconID {
            case "01d": imageRequest(type: ImagesEndpoint.clearSkyDay, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
            case "01n": imageRequest(type: ImagesEndpoint.clearSkyNight, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
            case "02d":  imageRequest(type: ImagesEndpoint.fewCloudsDay, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
            case "02n": imageRequest(type: ImagesEndpoint.fewCloudsNight, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
            case "03d": imageRequest(type:  ImagesEndpoint.scatteredCloudsDay, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
            case "03n": imageRequest(type:  ImagesEndpoint.scatteredCloudsNight, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
            case "04d": ImagesEndpoint.brokenClouds
            case "04n": ImagesEndpoint.brokenCloudsNight
            case "09d": ImagesEndpoint.showerRainDay
            case "09n": ImagesEndpoint.showerRainNight
            case "10d": ImagesEndpoint.rainDay
            case "10n": ImagesEndpoint.rainNight
            case "11d": ImagesEndpoint.thunderstormDay
            case "11n": ImagesEndpoint.thunderstormNight
            case "13d": ImagesEndpoint.snowDay
            case "13n": ImagesEndpoint.snowNight
            case "50d": ImagesEndpoint.mist
            case "50n": ImagesEndpoint.mistNight
//        TODO other cases of image
        }
    }
    
    func getWeatherByCoordinates(coords: Coordinates, completionHandler: @escaping (WeatherDataModel?, Error?) -> ()) {
        let decoder = JSONDecoder()
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByCoordinates(lattitude: coords.latitude, longtitute: coords.latitude), completion: {  (data, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        if let dataInner = data {
                            let weather = try? decoder.decode(WeatherDataModel.self, from: dataInner)//TODO handle posible exception of decoding
                            complitionHandler(weather, nil)
                        }
                        else {
                            //maybe some logic that handling exception when data is nil
                        }
                    case 404: throw NetworkError.notFound
                    case .none: complitionHandler(nil, error)
                    case .some(_): complitionHandler(nil, nil) //TODO make logic for other status codes
                }
            }
            catch let error
            {
                complitionHandler(nil, error)
            }
        })
    }
    
    private func imageRequest(type: EndPointType, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        networkSevice.makeRequest(with: type, cachePolicy: .useProtocolCachePolicy, completion: {(dataImage, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        guard let imgData = dataImage else {
                            throw NetworkError.notFound
                        }
                        let image = UIImage(data: imgData)
                        completionHandler(image, nil)
                        
                    case 404: throw NetworkError.notFound
                        
                    case .none: completionHandler(nil, error)
                        
                    case .some(_): completionHandler(nil, nil) //TODO make logic for other status codes
                }
            }
            catch let error
            {
                completionHandler(nil, error)
            }
        })
    }
    
    /* TODO: add different kinds of methods performing requests like getWeatherByCityName(name:completion:),
    getWeatherImage(iconId:completion:) etc, parse all JSON data inside a model, and return this model inside
    Result enum (which contains success and failure cases) using escaping closure */
    
    //TODO: handle responses
    
    //TODO: perform internet connection check
    
    //TODO: handle various errors
    
    //TODO: handle caching images (NSCache)
    
}
