//
//  Configuration.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// API Configuration
struct Configuration: Decodable {

    // MARK:
    // MARK: Enum

    private enum CodingKeys: CodingKey {
        enum Image: CodingKey {
            case secureBaseUrl
            case posterSizes
        }

        case images
    }

    // MARK:
    // MARK: Property

    /// base url
    let imageBaseURL: String

    /// List of poster sizes
    let posterSizes: [String]

    // MARK:
    // MARK: Initializers

    init(imageBaseURL: String, posterSizes: [String]) {
        self.imageBaseURL = imageBaseURL
        self.posterSizes = posterSizes
    }

    init(from decoder: Decoder) throws {
        let allValues = try decoder.container(keyedBy: CodingKeys.self)
        let imageValues = try allValues.nestedContainer(keyedBy: CodingKeys.Image.self, forKey: .images)

        imageBaseURL = try imageValues.decode(String.self, forKey: .secureBaseUrl)
        posterSizes = try imageValues.decode([String].self, forKey: .posterSizes)
    }
}
