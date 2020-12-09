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
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> Void)
    func getWeatherImage(iconId: String, completionHandler: @escaping (UIImage?) -> Void)
    func getWeatherByCoordinates(coords: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> Void)
}

class NetworkManager: NetManagerProtocol {
    // Singleton
    static let shared = NetworkManager()
    private let networkSevice = NetworkService()
    var weatherUnits: String {
        return UserDefaults.standard.string(forKey: "units") ?? "metric"
    }

    //One of Singleton conditions
    private init() {}

    func getWeatherDataByCityName(name: String, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        let decoder = JSONDecoder()
            networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name)) { result in
                    switch result {
                    case .success(let dataModelInner):
                        do {
                            let weather = try decoder.decode(WeatherDataModel.self, from: dataModelInner)
                            completionHandler(.success(weather))
                        } catch let error {
                            print( "\(error) in Net manager")
                        }
                    case .failure(let error):
                        print("\(error) in Net manager")
                        completionHandler(.failure(error))
                    }
                }
        }
    func getWeatherImage(iconId: String, completionHandler: @escaping (UIImage?) -> Void) {
        let imageCache = NSCache<NSString, UIImage>()
        if let imageEndpoint = ImagesEndpoint(rawValue: iconId) {
            if let imageFromCache = imageCache.object(forKey: NSString(string: imageEndpoint.rawValue)) {
                completionHandler(imageFromCache)
            }//imageCodes.keys.contains(iconID)
            networkSevice.makeRequest(with: imageEndpoint, cachePolicy: .useProtocolCachePolicy) { result in
                    switch result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            print("wrong image data")
                            completionHandler(nil)
                            return
                        }
                        imageCache.setObject(image, forKey: NSString(string: imageEndpoint.rawValue))
                        completionHandler(image)
                    case .failure(let error):
                        print(error)
                        completionHandler(nil)
                    }
                }
        } else {
            print("!!!ERROR!!! -> wrong iconID (icon code)")
            completionHandler(nil)
        }
    }
    func getWeatherByCoordinates(coords: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        let decoder = JSONDecoder()
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByCoordinates(lattitude: coords.latitude, longtitute: coords.longitude)) { result in
                    switch result {
                    case .success(let dataModelInner):
                        do {
                            let weather = try decoder.decode(WeatherDataModel.self, from: dataModelInner)
                            completionHandler(.success(weather))
                        } catch let error {
                            print( "\(error) in Net manager")
                        }
                    case .failure(let error):
                        print("\(error) in Net manager")
                        completionHandler(.failure(error))
                    }
                }
    }
}
