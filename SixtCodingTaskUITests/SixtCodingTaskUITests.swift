//
//  SixtCodingTaskUITests.swift
//  SixtCodingTaskUITests
//
//  Created by Max Trauboth on 18.11.20.
//

import XCTest

class SixtCodingTaskUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
    
    func testCellTap() {
        let app = XCUIApplication()
        app.launch()
        
        let listButton = app.buttons["List"]
        
        listButton.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Vanessa"]/*[[".cells.staticTexts[\"Vanessa\"]",".staticTexts[\"Vanessa\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(listButton.isHittable)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
