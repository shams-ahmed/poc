//
//  MovieTest.swift
//  pocTests
//
//  Created by Shams Ahmed on 22/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import Foundation
import XCTest
@testable import poc

class MovieTest: XCTestCase {

    let controller = MovieController()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMovieModel() {
        // Ideal storing json files of the responses and testing with this apporach is better
        // but for demo purposes i will leave it for now
        guard let data = """
            {
              "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
              "adult": false,
              "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
              "release_date": "2016-08-03",
              "genre_ids": [
                14,
                28,
                80
              ],
              "id": 297761,
              "original_title": "Suicide Squad",
              "original_language": "en",
              "title": "Suicide Squad",
              "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
              "popularity": 48.261451,
              "vote_count": 1466,
              "video": false,
              "vote_average": 5.91
            }
        """.data(using: .utf8) else { return XCTFail() }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let movie = try? decoder.decode(Movie.self, from: data) else { return XCTFail() }

        XCTAssertGreaterThanOrEqual(movie.id, 1)
        XCTAssert(!movie.title.isEmpty)
        XCTAssert(!movie.overview.isEmpty)
        XCTAssert(!movie.posterPath.isEmpty)
        XCTAssertGreaterThanOrEqual(movie.voteAverage, 0.1)
        XCTAssertNotNil(movie.releaseDate)
    }
}
