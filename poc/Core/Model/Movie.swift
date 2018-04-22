//
//  Movie.swift
//  poc
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation

/// Movie model
struct Movie: Decodable {

    // MARK:
    // MARK: Enum

    private enum CodingKeys: CodingKey {
        case id
        case title
        case overview
        case voteAverage
        case posterPath
        case releaseDate
    }

    // MARK:
    // MARK: Property

    /// movie id
    let id: Int

    /// movie title
    let title: String

    /// overview of movie
    let overview: String

    /// average votes
    let voteAverage: Double

    /// poster path
    let posterPath: String

    /// release date
    let releaseDate: Date

    // MARK:
    // MARK: Initializers

    init(from decoder: Decoder) throws {
        let allValues = try decoder.container(keyedBy: CodingKeys.self)

        id = try allValues.decode(Int.self, forKey: .id)
        title = try allValues.decode(String.self, forKey: .title)
        overview = try allValues.decode(String.self, forKey: .overview)
        voteAverage = try allValues.decode(Double.self, forKey: .voteAverage)
        posterPath = try allValues.decode(String.self, forKey: .posterPath)
        releaseDate = try allValues.decode(Date.self, forKey: .releaseDate)
    }
}

extension Movie: Hashable {

    // MARK:
    // MARK: Hashable

    var hashValue: Int { return id }

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        switch (lhs, rhs) {
        case (let l, let r): return l.hashValue == r.hashValue
        }
    }
}
