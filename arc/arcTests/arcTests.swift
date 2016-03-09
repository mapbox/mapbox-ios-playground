//
//  arcTests.swift
//  arcTests
//
//  Created by Tom MacWright on 2/19/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import XCTest
import CoreLocation
@testable import arc

class ArcTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(arc.greatCircle(
            CLLocationCoordinate2D(latitude: 0, longitude: 0),
            end: CLLocationCoordinate2D(latitude: 10, longitude: 10),
            points: 10).count, 11)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            arc.greatCircle(
                CLLocationCoordinate2D(latitude: 0, longitude: 0),
                end: CLLocationCoordinate2D(latitude: 10, longitude: 10),
                points: 10)
        }
    }

}
