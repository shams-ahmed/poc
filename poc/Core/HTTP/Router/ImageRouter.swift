//
//  ImageRouter.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Image router
enum ImageRouter: Router {

    // MARK:
    // MARK: Request

    /// fetch image
    case image(size: String, path: String)

    // MARK:
    // MARK: Request

    var method: HTTPSessionManager.Method {
        switch self {
        case .image: return .get
        }
    }

    var path: String {
        switch self {
        case .image(let size, let path): return size + path
        }
    }

    // MARK:
    // MARK: URLRequest

    /// Build request
    var url: URLRequest? {
        // build url with query items and path
        guard
            let imageUrl = Constants.API.imageUrl,
            var urlComponent = URLComponents(string: imageUrl) else { return nil }
        urlComponent.path += path

        guard let url = urlComponent.url else { return nil }

        // create request with http method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
