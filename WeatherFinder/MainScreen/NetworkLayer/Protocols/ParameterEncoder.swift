//
//  ParameterEncoder.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 14.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// Protocol, used for creating various encoders
protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
