//
//  HTTPTask.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 11.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// HTTPHeaders is a dictionary consisting of headers
typealias HTTPHeaders = [String: String]

// Parameters is a dictionary consisting of keys and various data type values
typealias Parameters = [String: Any]

// this enum can be extended with download cases, upload cases etc
enum HTTPTask {
    // Simple GET Request (can be used to get images, or any other kind of data)
    case getRequest
    // GET request with URL parameters (urlParameters are being composed in url using URLComponents class)
    case getRequestWithParameters(urlParameters: Parameters)
    /* POST Request with URL parameters or body parameters.
    
     - urlParameters are being composed in url using URLComponents class (You need to use
    "application/x-www-form-urlencoded" value of "Content-Type" header if you pass parameters in head of http)

     - bodyParameters are being encoded into JSON data (You must use "application/json" value of "Content-Type"
    header if you pass parameters in a body of http) */
    case postRequest(bodyParameters: Parameters?, urlParameters: Parameters?)
}
