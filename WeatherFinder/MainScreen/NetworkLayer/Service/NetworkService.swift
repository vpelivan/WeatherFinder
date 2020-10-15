//
//  NetworkService.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 08.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest(with endPoint: EndPointType, cachePolicy: URLRequest.CachePolicy,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func makeRequest(with endPoint: EndPointType,
                     cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let session = URLSession.shared
        
        do {
            let request = try buildURLRequest(with: endPoint, cachePolicy: cachePolicy)
            session.dataTask(with: request) { (data, response, error) in
                //In next project task we need to create NetworkManager, to process this data, responce and errors
                completion(data, response, error)
            }.resume()
        }
        catch let error {
            completion(nil, nil, error)
        }
    }
    
    private func buildURLRequest(with endPoint: EndPointType,
                                 cachePolicy: URLRequest.CachePolicy) throws -> URLRequest {
        
        let url = endPoint.baseURL.appendingPathComponent(endPoint.path)
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10)
        
        request.httpMethod = endPoint.httpMethod.rawValue
        do {
            switch endPoint.task {
            case .request:
                break
            case .requestWithParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters, urlParameters, &request)
            case .requestWithParametersAndHeaders(let bodyParameters,
                                                  let urlParameters,
                                                  let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, &request)
                try self.configureParameters(bodyParameters, urlParameters, &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(_ bodyParameters: Parameters?,
                                     _ urlParameters: Parameters?,
                                     _ request: inout URLRequest) throws {
        
        do {
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?,
                                      _ request: inout URLRequest) {
        
        guard let headers = additionalHeaders else { return }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
