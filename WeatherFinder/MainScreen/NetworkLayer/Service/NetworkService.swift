//
//  NetworkService.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 08.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest(with endPoint: EndPointType,
                     cachePolicy: URLRequest.CachePolicy,
                     completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    func makeRequest(with endPoint: EndPointType,
                     cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData,
                     completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared

        do {
            let request = try buildURLRequest(with: endPoint, cachePolicy: cachePolicy)
            session.dataTask(with: request) { (data, response, error) in
                do {
                    switch( response, error) {
                    case let (error as NSError, _):
                        switch error.code {
                        //case is URLError:
                        //   <#code#>
                        //case is Error
                        case NSURLErrorNetworkConnectionLost:
                            print(error)
                            throw NetworkError.failedInternetConnection
                        case NSURLErrorNotConnectedToInternet:
                            print(error)
                            throw NetworkError.failedInternetConnection
                        default:
                            print(error)
                            throw NetworkError.unknownError

                        }
                    case let (response as HTTPURLResponse, _):
                        switch response.statusCode {
                        case 200:
                            guard let dataInner = data else {
                                return
                            }
                            DispatchQueue.main.async(execute: {
                                completion(.success(dataInner))
                            })
                        //case 201...299:
                        case 404: throw NetworkError.notFound
                        default:
                            throw NetworkError.otherStatusCode
                        }
                    case (_, _):
                        throw NetworkError.unknownError
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }.resume()
        } catch let error {
            completion(.failure(error))
        }
    }

    private func buildURLRequest(with endPoint: EndPointType,
                                 cachePolicy: URLRequest.CachePolicy) throws -> URLRequest {

        let url = endPoint.baseURL.appendingPathComponent(endPoint.path)
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10)

        request.httpMethod = endPoint.httpMethod.rawValue
        addHeaders(endPoint.headers, &request)
        do {
            switch endPoint.task {
            case .getRequest:
                break
            case .getRequestWithParameters(let urlParameters):
                try self.setURLParameters(urlParameters, &request)
            case .postRequest(let bodyParameters, let urlParameters):
                try self.configurePOSTParameters(urlParameters, bodyParameters, &request)
            }
            return request
        } catch {
            throw error
        }
    }

    private func addHeaders(_ headers: HTTPHeaders?,
                            _ request: inout URLRequest) {

        guard let headers = headers else { return }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    private func setURLParameters(_ urlParameters: Parameters,
                                  _ request: inout URLRequest) throws {
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        } catch {
            throw error
        }
    }

    private func setBodyParameters(_ bodyParameters: Parameters,
                                   _ request: inout URLRequest) throws {

        do {
            try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
        } catch {
            throw error
        }
    }

    private func configurePOSTParameters(_ urlParameters: Parameters?,
                                         _ bodyParameters: Parameters?,
                                         _ request: inout URLRequest) throws {

        guard !(bodyParameters == nil && urlParameters == nil) else {
            throw NetworkError.nilParameters
        }
        if let urlParameters = urlParameters {
            try self.setURLParameters(urlParameters, &request)
        }
        if let bodyParameters = bodyParameters {
            try self.setBodyParameters(bodyParameters, &request)
        }
    }
}
