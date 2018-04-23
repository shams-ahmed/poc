//
//  CustomView.swift
//  poc
//
//  Created by Shams Ahmed on 23/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Custom view
protocol CustomView {

    associatedtype T

    /// Unwrap a custom view or fatalError
    var getView: T { get }
}
