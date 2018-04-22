//
//  ConfigurationRouter.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Configuration router
enum ConfigurationRouter: Router {

    // MARK:
    // MARK: Request

    /// fetch image
    case configuration(APIKey: String)

    // MARK:
    // MARK: Request

    var method: HTTPSessionManager.Method {
        switch self {
        case .configuration: return .get
        }
    }

    var path: String {
        switch self {
        case .configuration: return "/3/configuration"
        }
    }

    // MARK:
    // MARK: URLRequest

    /// Build request
    var url: URLRequest? {
        // build url with query items and path
        guard var urlComponent = URLComponents(string: Constants.API.url) else { return nil }
        urlComponent.path = path

        switch self {
        case .configuration(let key):
            urlComponent.queryItems = [URLQueryItem(name: "api_key", value: key)]
        }

        guard let url = urlComponent.url else { return nil }

        // create request with http method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
