//
//  NetworkError.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 13.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// All kinds of errors that might occure during composing a URLRequest
enum NetworkError: String, Error {
    case urlMissing = "URL is nil"
    case encodingFailed = "Parameter encoding failed"
    case nilParameters = "Paremeters in request cannot be nil"
    case notFound = "404 Requested page not found"
}

