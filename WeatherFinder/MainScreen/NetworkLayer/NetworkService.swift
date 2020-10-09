//
//  NetworkService.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 08.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getData(from urlString: String, cachePolicy: URLRequest.CachePolicy, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    //Need to organize cache policy, configure URLRequest (still in progress)
    func getData(from urlString: String,
                 cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            //In next task we need to create NetworkManager, to process this data, responce and errors
            completion(data, response, error)
        }
        task.resume()
    }
}
