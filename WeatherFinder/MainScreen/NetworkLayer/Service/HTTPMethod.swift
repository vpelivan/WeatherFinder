//
//  HTTPMethod.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 12.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// this enum can be extended with various http method cases, I took the one that our API supports
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}
