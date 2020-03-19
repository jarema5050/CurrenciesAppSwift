//
//  currenciesTests.swift
//  currenciesTests
//
//  Created by Jedrzej Sokolowski on 17/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import XCTest
@testable import currencies

class HeaderViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializer_ShouldSetupAllButtonsAndEmbedInStackView() {
        //arrange
        let headerView = HeaderView(frame: .zero)
        let stackView = headerView.subviews[0] as? UIStackView
        //assert
        XCTAssert(headerView.subviews.count == 1, "Count of subviews is different than 1")
        XCTAssert(type(of:headerView.subviews[0]) == UIStackView.self, "Subview is not a stackview")
        if let stackView = stackView {
            XCTAssert(stackView.arrangedSubviews.count == 3, "3 buttons are not embeded in subcview")
            
            stackView.arrangedSubviews.forEach({ button in
                XCTAssert(type(of: button) == TableButton.self, "button isn't of type TableButton")
            })
        }
    }

}
