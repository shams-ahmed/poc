//
//  ImageControllerTest.swift
//  pocTests
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import XCTest
@testable import poc

class ImageControllerTest: XCTestCase {

    let controller: ImageController = {
        let configuration = ConfigurationController()
        configuration.configuration = Configuration(
            imageBaseURL: "https://image.tmdb.org/t/p/",
            posterSizes: ["w200", "w500", "original"])

        return ImageController(configuration: configuration)
    }()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK:
    // MARK: Test

    func testFetchImage() {
        // Giving more time i would of used Quick/Nimble with Mockingjay setup
        let exp = expectation(description: "fetch configurations")

        var image: UIImage?

        Constants.API.imageUrl = "https://image.tmdb.org/t/p/"

        controller.image(.high, for: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg") {
            switch $0 {
            case .success(let newImage): image = newImage
            case .failed: XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0)

        XCTAssertNotNil(image)
    }
}
