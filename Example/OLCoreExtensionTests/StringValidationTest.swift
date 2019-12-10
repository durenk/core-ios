//
//  StringValidationTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 03/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class StringValidationTest: XCTestCase {

    override func setUp() {}
    override func tearDown() {}

    func testIsValidURL() {
        let inputText = "https://google.com"
        XCTAssertTrue(inputText.isValidURL(), "Wrong URL Format!")
    }
}
