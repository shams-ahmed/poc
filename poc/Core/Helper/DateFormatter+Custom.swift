//
//  DateFormatter+Custom.swift
//  poc
//
//  Created by Shams Ahmed on 22/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

extension DateFormatter {

    // MARK:
    // MARK: Custom

    /// Formatter for "mmmm d, yyyy" i.e March 20, 2018
    static let mmmmDyyyy: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = "MMMM d, yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current

        return formatter
    }()

    /// Formatter for "yyyy-MM-dd" i.e 2018-22-18
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current

        return formatter
    }()
}
