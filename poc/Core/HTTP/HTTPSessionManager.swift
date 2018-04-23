//
//  HTTPSessionManager.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Handle all HTTP request
class HTTPSessionManager {

    // MARK:
    // MARK: Typealias

    typealias HTTPResult = Result<Data>

    // MARK:
    // MARK: Enum

    enum Method: String {
        case get = "GET"
        case delete = "DELETE"
        case post = "POST"
        case put = "PUT"
    }

    enum Errors: Error {
        case unknown
        case requestCannotBeConstructed
        case invalidResponse
    }

    // MARK:
    // MARK: Static - Task

    /// Make a request
    static func dataTask(for request: URLRequest,
        _ completion: @escaping (HTTPResult) -> Void) -> URLSessionDataTask {
        // create a data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // retry operation could done here by checking the status code
            guard error == nil, let data = data else {
                return completion(HTTPResult.failed(error ?? Errors.unknown))
            }

            // look status code, for demo purposes will leave like this
            // API state 401 is returned for api key error's
            if (response as? HTTPURLResponse)?.statusCode == 401 {
                print("Invalid API key: Please update `Constants.API.Key` with your API key")
            }

            // pass success
            completion(HTTPResult.success(data))
        }

        return task
    }
}
