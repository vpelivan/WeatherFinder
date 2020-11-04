//
//  NetworkManager.swift
//  WeatherFinder
//
//  Created by Romanovskiy Volodymyr on 15.10.2020.
//  Copyright © 2020 Romanovskiy Volodymyr. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol NetManagerProtocol {
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> ())
    func getWeatherImage(iconID: String) -> UIImage?
    func getWeatherByCoordinates(coords: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> ())
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
    
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> ()) {
        let decoder = JSONDecoder()
        DispatchQueue.main.async(execute:  { [weak self] in
            self?.networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name), completion: {  (data, response, error) -> Void in
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
                        case 404: completionHandler(.failure(NetworkError.notFound))
                        case .none:
                            if let errorUnwrapped = error {
                                throw  errorUnwrapped
                            }
                        case .some(_):
                            if let errorUnwrapped = error {
                                throw  errorUnwrapped
                            }
                    }
                }
                catch let error
                {
                    print(error)
                    completionHandler(.failure(error ))
                }
            })
        })
    }
    
    func getWeatherImage(iconID: String) -> UIImage? {
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
        
        var image: UIImage? =  UIImage()
        if let imageEndpoint = imageCodes[iconID] { //imageCodes.keys.contains(iconID)
            imageRequest(type: imageEndpoint) { result in
                switch result {
                case .success(let receivedImage):
                     image = receivedImage
                case .failure(let error):
                    print(error)
                    image = nil
                }
            }
        }
        else {
            print("!!!ERROR!!! -> wrong iconID (icon code)")// TODo maybe other error handling
        }
        return image
    }
    
    func getWeatherByCoordinates(coords: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> ()) {
        let decoder = JSONDecoder()
        DispatchQueue.main.async(execute:  { [weak self] in // maybe reference cycle
            self?.networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByCoordinates(lattitude: coords.latitude, longtitute: coords.longitude), completion: {  (data, response, error) -> Void in
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
                        case 404: completionHandler(.failure(NetworkError.notFound))
                        case .none:
                            if let errorUnwrapped = error {
                                throw  errorUnwrapped
                            }
                        case .some(_):
                            if let errorUnwrapped = error {
                                throw  errorUnwrapped
                            }
                    }
                }
                catch let error
                {
                    print(error)
                    completionHandler(.failure(error))
                }
            })
        })
    }
    
    private func imageRequest(type: ImagesEndpoint, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        let imageCache = NSCache<NSString, UIImage>();
        if let image = imageCache.object(forKey: NSString(string: type.rawValue)) {
            completionHandler(.success(image))
            return
        }
        
        DispatchQueue.main.async(execute:  {
            self.networkSevice.makeRequest(with: type, cachePolicy: .useProtocolCachePolicy, completion: {(dataImage, response, error) -> Void in
                do {
                    if let errorInner = error {
                        throw errorInner
                    }
                    let httpResponse = response as? HTTPURLResponse
                    switch httpResponse?.statusCode {
                        case 200 :
                            guard let imgData = dataImage, let image = UIImage(data: imgData) else {
                                throw NetworkError.notFound
                            } // downloaded Image
                            imageCache.setObject(image, forKey: NSString(string: type.rawValue))
                            completionHandler(.success(image))
                        case 404: throw NetworkError.notFound
                        case .none:
                            if let errorUnwrapped = error {
                                throw  errorUnwrapped
                            }
                        case .some(_): completionHandler(.failure(NetworkError.notFound)) //TODO make logic for other status codes
                    }
                }
                catch let error
                {
                    completionHandler(.failure(error))
                }
            })
        })
    }
}
