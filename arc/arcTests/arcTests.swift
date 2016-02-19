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

class arcTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(arc.greatCircle(
            CLLocationCoordinate2D(latitude: 0, longitude: 0),
            end: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            points: 10), false);
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
