//
//  NetworkManager.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 15.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class NetworkManager {

    // Singleton
    static let shared = NetworkManager()

    // external dependencies
    private let networkSevice = NetworkService()

    /* weather units should be updated in UserDefaults from somewhere else (for example,
    application settings menu controller class). Probably, a new Trello task with UserDefaults
    setup should be created */
    var weatherUnits: String {
        return UserDefaults.standard.string(forKey: "units") ?? "metric"
    }

    //One of Singleton conditions
    private init() {}

    /*TODO: Further methods and properties are plugs to immitate the work of network manager, because of absence
     of this methods. I wrote them for testing purposes, they must be deleted after the network manager is
     written, I do not handle errors and responces here - just getting data */
    private var imageCache = NSCache<NSString, UIImage>()

    func getCityWeatherByName(name: String, completion: @escaping (WeatherDataModel?) -> Void) {
        networkSevice.makeRequest(with: WeatherApiEndpoint.findCityByName(name: name)) { (data, _, _) in
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(model)
                    }
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }

    func getWeatherImage(iconId: String, completion: @escaping (UIImage?) -> Void) {
        guard let endpoint = ImagesEndpoint(rawValue: iconId) else {
            completion(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: endpoint.path as NSString) {
            completion(cachedImage)
        }
        networkSevice.makeRequest(with: endpoint, cachePolicy: .returnCacheDataElseLoad) { [weak self] (data, _, _) in
            if let data = data, let image = UIImage(data: data), let self = self {
                self.imageCache.setObject(image, forKey: endpoint.path as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
}
