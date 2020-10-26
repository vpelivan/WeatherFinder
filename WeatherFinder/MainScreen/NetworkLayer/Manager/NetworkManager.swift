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
    
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (Result<WeatherDataModel, NetworkError>) -> ()) {
        let decoder = JSONDecoder()
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name), completion: {  (data, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        guard let dataInner = data
                        else {
                            return
                            //maybe some logic that handling exception when data is nil
                        }
                        let weather = try decoder.decode(WeatherDataModel.self, from: dataInner)
                            //TODO handle posible exception of decoding
                        completionHandler(.success(weather))
                    case 404: completionHandler(.failure(.notFound))
                    case .none: completionHandler(.failure(error as! NetworkError))
                    case .some(_): completionHandler(.failure(error as! NetworkError))
                }
            }
            catch let error
            {
                print(error)
                completionHandler(.failure(error as! NetworkError))
            }
        })
    }
    
    func getWeatherImage(iconID: String, completionHandler: @escaping (UIImage?) -> Void) //data.hashValue method
    {
        let imageCodes: [String: ImagesEndpoint] = [
            "01d": ImagesEndpoint.clearSkyDay,
            "01n": ImagesEndpoint.clearSkyNight,
            "02d": ImagesEndpoint.fewCloudsDay,
            "02n": ImagesEndpoint.fewCloudsNight,
            "03d": ImagesEndpoint.scatteredCloudsDay,
            "03n": ImagesEndpoint.scatteredCloudsNight,
            "04d": ImagesEndpoint.brokenClouds,
            "04n": ImagesEndpoint.brokenCloudsNight,
            "09d": ImagesEndpoint.showerRainDay,
            "09n": ImagesEndpoint.showerRainNight,
            "10d": ImagesEndpoint.rainDay,
            "10n": ImagesEndpoint.rainNight,
            "11d": ImagesEndpoint.thunderstormDay,
            "11n": ImagesEndpoint.thunderstormNight,
            "13d": ImagesEndpoint.snowDay,
            "13n": ImagesEndpoint.snowNight,
            "50d": ImagesEndpoint.mist,
            "50n": ImagesEndpoint.mistNight
        ]
        
        if imageCodes.keys.contains(iconID) {
            imageRequest(type: imageCodes[iconID]!, completionHandler: {(image, error) -> Void in
                do {
                        try completionHandler(image)
                }
                catch let error{
                    print(error)
                    completionHandler(nil)
                }
            })
        }
        else {
            print("!!!ERROR!!! -> wrong iconID(icon code)")// TODo maybe other error handling
        }
    }
    
    func getWeatherByCoordinates(coords: Coordinates, completionHandler: @escaping (Result<WeatherDataModel, NetworkError>) -> ()) {
        let decoder = JSONDecoder()
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByCoordinates(lattitude: coords.latitude, longtitute: coords.longitude), completion: {  (data, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                    case 200 :
                        guard let dataInner = data
                        else {
                            return
                            //maybe some logic that handling exception when data is nil
                        }
                        let weather = try decoder.decode(WeatherDataModel.self, from: dataInner)
                            //TODO handle posible exception of decoding
                        completionHandler(.success(weather))
                    case 404: completionHandler(.failure(.notFound))
                    case .none: completionHandler(.failure(error as! NetworkError))
                    case .some(_): completionHandler(.failure(error as! NetworkError))
                }
            }
            catch let error
            {
                print(error)
                completionHandler(.failure(error as! NetworkError))
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
