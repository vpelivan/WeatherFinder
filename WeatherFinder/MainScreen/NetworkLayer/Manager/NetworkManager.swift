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
        
        var image: UIImage? =  UIImage() //maybe better initialize nil
        let imageCache = NSCache<NSString, UIImage>();
        if let imageEndpoint = imageCodes[iconID] {
            if let imageFromCache = imageCache.object(forKey: NSString(string: imageEndpoint.rawValue)) {
                return imageFromCache
            }//imageCodes.keys.contains(iconID)
            
            DispatchQueue.main.async(execute:  {
                self.networkSevice.makeRequest(with: imageEndpoint, cachePolicy: .useProtocolCachePolicy) { result in
                    switch result {
                    case .success(let data):
                        do {
                            guard let image = UIImage(data: data) else {}
                       
                            try imageCache.setObject(image, forKey: NSString(string: imageEndpoint.rawValue))
                        }
                        catch {
                            print("Exception of Caching")
                            break
                        }
                    case .failure(let error):
                        print(error)
                        image = nil
                    }
                }
            })
        }
        else {
            print("!!!ERROR!!! -> wrong iconID (icon code)")// TODo maybe other error handling
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
}
