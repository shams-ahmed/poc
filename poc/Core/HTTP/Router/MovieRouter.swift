//
//  MovieRouter.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Routes for Movies
enum MovieRouter: Router {

    /// Popular movies by page
    case popular(APIKey: String, page: Int)

    // MARK:
    // MARK: Request

    var method: HTTPSessionManager.Method {
        switch self {
        case .popular: return .get
        }
    }

    var path: String {
        switch self {
        case .popular: return "/3/movie/popular"
        }
    }

    // MARK:
    // MARK: URLRequest

    /// Build request
    var url: URLRequest? {
        // build url with query items and path
        guard var urlComponent = URLComponents(string: Constants.API.url) else { return nil }
        urlComponent.path = path

        // this part would look better using builder pattern
        // to time-box this i'll leave it
        switch self {
        case .popular(let key, let page):
            urlComponent.queryItems = [
                URLQueryItem(name: "api_key", value: key),
                URLQueryItem(name: "page", value: String(page))
            ]
        }

        guard let url = urlComponent.url else { return nil }

        // create request with http method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
