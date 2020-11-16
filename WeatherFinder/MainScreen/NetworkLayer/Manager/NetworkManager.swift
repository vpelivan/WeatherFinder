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
    
    var weatherUnits: String {
        return UserDefaults.standard.string(forKey: "units") ?? "metric"
    }

    //One of Singleton conditions
    private init() {}
    
    func getWeatherDataByCityName(name: String, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> ()) {
        let decoder = JSONDecoder()
        DispatchQueue.main.async(execute:  { [weak self] in
            self?.networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name)) { result in
                    switch result {
                    case .success(let dataModelInner):
                        do {
                            let weather = try decoder.decode(WeatherDataModel.self, from: dataModelInner)
                            //TODO handle posible exception of decoding
                            completionHandler(.success(weather))
                        }
                        catch let error {
                            print( "\(error) in Net manager")
                        }
                    case .failure(let error):
                        print("\(error) in Net manager")
                        completionHandler(.failure(error))
                    }
                }
                
            })
        }
    
    func getWeatherImage(iconID: String) -> UIImage? {        
        var image: UIImage? =  nil
        let imageCache = NSCache<NSString, UIImage>();
        if let imageEndpoint = ImagesEndpoint(rawValue: iconID) {
            if let imageFromCache = imageCache.object(forKey: NSString(string: imageEndpoint.rawValue)) {
                return imageFromCache
            }//imageCodes.keys.contains(iconID)
            
            DispatchQueue.main.async(execute:  {
                self.networkSevice.makeRequest(with: imageEndpoint, cachePolicy: .useProtocolCachePolicy) { result in
                    switch result {
                    case .success(let data):
                        guard let imageFromData = UIImage(data: data) else {
                            print("wrong image data")
                            return
                        }
                        image = imageFromData
                        imageCache.setObject(imageFromData, forKey: NSString(string: imageEndpoint.rawValue))
                        
                    case .failure(let error):
                        print(error)
                        image = nil
                    }
                }
            })
        }
        else {
            print("!!!ERROR!!! -> wrong iconID (icon code)")
        }
        return image
    }
    
    func getWeatherByCoordinates(coords: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherDataModel, Error>) -> ()) {
        let decoder = JSONDecoder()
        DispatchQueue.main.async(execute:  { [weak self] in // maybe reference cycle
            self?.networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByCoordinates(lattitude: coords.latitude, longtitute: coords.longitude)) { result in
                    switch result {
                    case .success(let dataModelInner):
                        do {
                            let weather = try decoder.decode(WeatherDataModel.self, from: dataModelInner)
                            completionHandler(.success(weather))
                        }
                        catch let error {
                            print( "\(error) in Net manager")
                        }
                    case .failure(let error):
                        print("\(error) in Net manager")
                        completionHandler(.failure(error))
                    }
                }
        })
    }
}
