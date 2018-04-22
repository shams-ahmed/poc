//
//  MovieControllerTest.swift
//  pocTests
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import XCTest
import poc
@testable import poc

class MovieControllerTest: XCTestCase {

    let controller = MovieController()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK:
    // MARK: Test

    func testFetchMovies() {
        // Giving more time i would of used Quick/Nimble with Mockingjay setup
        let exp = expectation(description: "fetch movies")

        XCTAssertEqual(controller.currentPagination, 1)
        XCTAssertEqual(controller.movies.isEmpty, true)

        controller.fetchMorePopularMovies { _ in
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0)

        XCTAssertEqual(controller.currentPagination, 2)
        XCTAssertEqual(controller.movies.isEmpty, false)
        XCTAssertEqual(controller.movies.count, 20)

        guard let movie = controller.movies.first else { return XCTFail() }

        XCTAssertGreaterThanOrEqual(movie.id, 1)
        XCTAssert(!movie.title.isEmpty)
        XCTAssert(!movie.overview.isEmpty)
        XCTAssert(!movie.posterPath.isEmpty)
        XCTAssertGreaterThanOrEqual(movie.voteAverage, 0.1)
        XCTAssertNotNil(movie.releaseDate)
    }
}
