//
//  RequestConfigurationProtocol.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 11.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

/* this protocol helps with configuring any request, defines all the needed info like baseURL,
   url path, type of http method, tasks and headers */
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get } // enum with cases of HTTPMethods
    var task: HTTPTask { get } // enum with cases of kind of request
    var headers: HTTPHeaders? { get } // dictionary of type [string : string] of headers
}
