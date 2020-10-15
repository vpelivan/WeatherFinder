//
//  HTTPTask.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 11.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// HTTPHeaders is a dictionary consisting of headers
typealias HTTPHeaders = [String : String]

// Parameters is a dictionary consisting of keys and various data type values
typealias Parameters = [String : Any]

// this enum can be extended with download cases, upload cases etc
enum HTTPTask {
    // Simple Request (can be used to get images, or any other kind of data)
    case request
    /* Request with parameters. Body is used for POST request to encode serialized JSON data
    and post it on server (must be nil, if you perform GET requests), urlParameters composes
    url using URLComponents class) */
    case requestWithParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    /* Request with parameters and additional headers (to set http headers like encoding
    or "application/json" in "Content-Type" header field) */
    case requestWithParametersAndHeaders(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         additionalHeaders: HTTPHeaders?)
}
