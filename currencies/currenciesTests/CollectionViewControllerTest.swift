//
//  CollectionViewControllerTest.swift
//  currenciesTests
//
//  Created by Jedrzej Sokolowski on 21/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import XCTest
@testable import currencies

class CollectionViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetupCollectionView_ShouldInitializeRefreshControl() {
        let layout = UICollectionViewFlowLayout()
        let controller = CollectionViewController(collectionViewLayout: layout)
        
        controller.setupCollectionView()
        
        XCTAssert(controller.collectionView.refreshControl != nil, "Refresh control isn't initialized")
    }
    
    func testChangeDataSource_ShouldChangeEndpointProperty(){
        let layout = UICollectionViewFlowLayout()
        let controller = CollectionViewController(collectionViewLayout: layout)
        
        controller.changeDataSource(endpoint: Endpoints.TableB)
        XCTAssert(controller.currentEndpoint == Endpoints.TableB, "Current endpoint did't change")
    }
}
