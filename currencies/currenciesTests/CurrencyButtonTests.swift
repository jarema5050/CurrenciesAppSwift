//
//  CurrencyButtonTests.swift
//  currenciesTests
//
//  Created by Jedrzej Sokolowski on 19/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import XCTest
@testable import currencies
class CurrencyButtonTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializer_ShouldSetup4LabelsAsSubview() {
        let argumentsArray = ["4.2", "01-01-0001", "GHP", "Grand Hepalski"]
        let currencyButton = CurrencyButton(mid: argumentsArray[0], date: argumentsArray[1], code: argumentsArray[2], name: argumentsArray[3])
        let subviews = currencyButton.subviews
        
        
        XCTAssert(subviews.count == 4, "Unexpected number of subviews - should be 4")
        subviews.forEach({label in
            XCTAssert(type(of: label) == UILabel.self, "Subviews should be type of UILabel")
            let label = label as! UILabel
            XCTAssert(argumentsArray.contains(label.text!), "Labels hasn't proper texts inside")
        })
    }
}
