//
//  MovieResponse.swift
//  poc
//
//  Created by Shams Ahmed on 19/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Movie response model
struct MovieResponse: Decodable {

    // MARK:
    // MARK: Enum

    private enum CodingKeys: CodingKey {
        case page
        case results
    }

    // MARK:
    // MARK: Property

    /// Current page of movies
    let page: Int

    /// List of movies
    let movies: [Movie]

    // MARK:
    // MARK: Initializers

    init(from decoder: Decoder) throws {
        let allValues = try decoder.container(keyedBy: CodingKeys.self)

        page = try allValues.decode(Int.self, forKey: .page)
        movies = try allValues.decode([Movie].self, forKey: .results)
    }
}
