//
//  ConfigurationControllerTest.swift
//  pocTests
//
//  Created by Shams Ahmed on 21/04/18.
//  Copyright © 2018 Shams Ahmed. All rights reserved.
//

import Foundation
import XCTest
@testable import poc

class ConfigurationControllerTest: XCTestCase {

    let controller = ConfigurationController()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK:
    // MARK: Test

    func testFetchingConfiguration() {
        // Giving more time i would of used Quick/Nimble with Mockingjay setup
        let exp = expectation(description: "fetch configurations")

        controller.fetchConfiguration { _ in
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0)

        XCTAssertNotNil(controller.configuration)
        XCTAssert(controller.configuration?.imageBaseURL.isEmpty == false)
        XCTAssert(controller.configuration?.posterSizes.isEmpty == false)
    }
}
