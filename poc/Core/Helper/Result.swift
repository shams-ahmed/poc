//
//  Result.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Completion block with result
///
/// - success: result with T object
/// - failed: failed with error
enum Result<T> {
    /// result with T object
    case success(T)
    /// failed with error
    case failed(Error)
}
