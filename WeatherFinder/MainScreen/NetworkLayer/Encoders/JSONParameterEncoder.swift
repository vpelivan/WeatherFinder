//
//  JSONParameterEncoder.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 14.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {

    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let serializedJson = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = serializedJson
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
