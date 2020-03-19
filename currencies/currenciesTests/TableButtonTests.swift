//
//  TableButtonTests.swift
//  currenciesTests
//
//  Created by Jedrzej Sokolowski on 19/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import XCTest
@testable import currencies
class TableButtonTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializer_ShouldSetup2SubviewsOfTypeUILabel() {
        let argumentsArray = ["Deka", "TABELA"]
        let tableButton = TableButton(name: argumentsArray[0])
        let subviews = tableButton.subviews
        XCTAssert(subviews.count == 2, "It should be 2 subviews")
        
        subviews.forEach({label in
            XCTAssert(type(of: label) == UILabel.self, "Subviews should be type of UILabel")
            let label = label as! UILabel
            XCTAssert(argumentsArray.contains(label.text!), "Labels hasn't proper texts inside")
        })
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
