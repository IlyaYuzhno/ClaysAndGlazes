//
//  ClaysAndGlazesTests.swift
//  ClaysAndGlazesTests
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//

import XCTest
@testable import ClaysAndGlazes

class ClaysAndGlazesTests: XCTestCase {
    var interactor: Interactor?

    override func setUpWithError() throws {
        interactor = Interactor()
    }

    override func tearDownWithError() throws {
       interactor = nil
    }

    // MARK: - Tests
    func testGetTemperature() throws {
        let temperature = expectation(description: "Temperatures Received")
        _ = try XCTUnwrap(interactor).getTemperature(for: "S-6141, МКЛ-1") { response in
            switch response[0] {
            case "1050°":
                temperature.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testGetClays() throws {
        let clay = expectation(description: "Clays Received")
        _ = try XCTUnwrap(interactor).getClays(){ response in
            let witgert = response.filter { $0.brand == "Witgert" }.map { $0.clay}
            switch witgert[0] {
            case "Witgert 6, S-6500":
                clay.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testGetGlazes() throws {
        let glaze = expectation(description: "Glaze Received")
        _ = try XCTUnwrap(interactor).getGlazes(for: "S-6141, МКЛ-1", temperature: "1050°", crackleId: "mnogo") { response in
            switch response[0] {
            case "S-0104":
                glaze.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testGetGlazesBrand() throws {
        let brand = expectation(description: "Brand Received")
        _ = try XCTUnwrap(interactor).getGlazesBrand(for: "S-0104") { response in
            switch response[0] {
            case "Lab Ceramica":
                brand.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testPerformanceExample() throws {
        self.measure {

        }
    }

}
