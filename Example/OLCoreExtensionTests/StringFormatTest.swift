//
//  StringFormatTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 03/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class StringFormatTest: XCTestCase {

    override func setUp() {}
    override func tearDown() {}

    func testThousandTextFormat() {
        var inputText = "10000000"
        inputText = inputText.withThousandSeparator()
        let expectedResult = "10.000.000"
        XCTAssertEqual(inputText, expectedResult, "Wrong Format!")
    }

    func testRemoveAllWhitespaces() {
        let inputText = "Text Dengan Banyak Spasi \n Text Dengan Banyak Spasi"
        let expectedResult = "TextDenganBanyakSpasiTextDenganBanyakSpasi"
        XCTAssertEqual(inputText.removeAllWhitespaces(), expectedResult, "Whitespaces remained!")
    }

    func testGetFirstWord() {
        let inputText = "satu dua tiga empat lima enam tujuh delapan"
        let expectedResult = "satu"
        XCTAssertEqual(inputText.getFirstWord(), expectedResult, "Wrong First Word!")
    }

    func testGetPrefix() {
        let inputText = "081110000121"
        let expectedResult = "08111"
        XCTAssertEqual(inputText.getPrefix(5), expectedResult, "Wrong Prefix!")
    }

    func  testGetSuffix() {
        let inputText = "081110000121"
        let expectedResult = "00121"
        XCTAssertEqual(inputText.getSuffix(5), expectedResult)
    }

    func testFloatValue() {
        let inputText = "9.8987"
        let expectedResult = Float(9.8987)
        XCTAssertEqual(inputText.floatValue, expectedResult)
    }

    func testDoubleValue() {
        let inputText = "9.8987"
        let expectedResult = Double(9.8987)
        XCTAssertEqual(inputText.doubleValue, expectedResult)
    }

}
