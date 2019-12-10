//
//  DoubleExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 19/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import OLCore

class DoubleExtensionTest: XCTestCase {
    var doubleValue = DefaultValue.emptyDouble

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testToCurrencyIDR() {
        doubleValue = 10000000
        let expectedValue = "Rp 10.000.000"
        XCTAssertEqual(doubleValue.toCurrencyIDR(), expectedValue)
    }

    func testRemoveZerosFromEnd() {
        doubleValue = 100.00
        let expectedValue = "100"
        XCTAssertEqual(doubleValue.removeZerosFromEnd(), expectedValue)
    }
}
