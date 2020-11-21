//
//  WebServiceTests.swift
//  SixtCodingTaskTests
//
//  Created by Max Trauboth on 18.11.20.
//

import XCTest
@testable import SixtCodingTask

class WebServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadCars() {
        // Arrange
        let expectation = XCTestExpectation(description: "Load cars")
        
        // Act
        WebService.loadCars { cars in
            // Assert
            XCTAssertNotNil(cars)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
