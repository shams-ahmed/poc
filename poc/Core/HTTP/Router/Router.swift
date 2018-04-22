//
//  Router.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Protocol for all request
protocol Router {

    /// HTTP method
    var method: HTTPSessionManager.Method { get }

    /// path
    var path: String { get }

    /// request
    var url: URLRequest? { get }
}
