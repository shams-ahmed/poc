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
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            // retry operation could done here by checking the status code
            guard error == nil, let data = data else {
                return completion(HTTPResult.failed(error ?? Errors.unknown))
            }

            // look status code as well, for demo purposes will leave this out

            // pass success
            completion(HTTPResult.success(data))
        }

        return task
    }
}
