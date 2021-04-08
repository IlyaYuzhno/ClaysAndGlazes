//
//  ClaysAndGlazesUITests.swift
//  ClaysAndGlazesUITests
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import XCTest

class ClaysAndGlazesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: Test
    func testUI() throws {

        let sectionHeader = app.otherElements["sectionHeader"].firstMatch
        sectionHeader.tap()

        let clayCell = app.cells["clayCell"].firstMatch
        clayCell.tap()

        let temperatureView = app.tables["temperaturesTableView"].firstMatch
        XCTAssertTrue(temperatureView.waitForExistence(timeout: 5))

        let temperCell = app.cells["temperatureCell"].firstMatch
        temperCell.tap()

        let crackleView = app.tables["cracklesTableView"].firstMatch
        XCTAssertTrue(crackleView.waitForExistence(timeout: 5))

        let crackleCell = app.cells["crackleCell"].firstMatch
        crackleCell.tap()

        let glazesView = app.tables["glazesTableView"].firstMatch
        XCTAssertTrue(glazesView.waitForExistence(timeout: 5))
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
