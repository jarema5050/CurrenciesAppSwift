//
//  CollectionViewCellTests.swift
//  currenciesTests
//
//  Created by Jedrzej Sokolowski on 19/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import XCTest
@testable import currencies
class CollectionViewCellTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetButton_ShouldSetupSubviewOfTypeCurrencyButton() {
        let cell = CollectionViewCell(frame: .zero)
        
        cell.setButton(mid: "", date: "", code: "", name:"")
        XCTAssert(cell.subviews.count == 2, "Count should be only 2")
        XCTAssert(type(of: cell.subviews[1]) == CurrencyButton.self, "Type of subview isn't proper")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


}
