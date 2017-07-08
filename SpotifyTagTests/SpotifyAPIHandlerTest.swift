//
//  SpotifyAPIHandlerTest.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 08/07/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import XCTest
import Sync
@testable import SpotifyTag

class SpotifyAPIHandlerTest: XCTestCase {
    
    var stack:DataStack!
    var api:SpotifyAPIHandler!
    var dataHandler:CoreDataHandler!
    
    override func setUp() {
        super.setUp()
        
        self.stack = DataStack(modelName: "SpotifyTag", bundle: Bundle.main, storeType: .inMemory)
        self.api = SpotifyAPIHandler(dataStack: stack, baseEndpoint: "")
        self.dataHandler = CoreDataHandler(dataStack: stack)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.stack.mainContext = stack.newNonMergingBackgroundContext() //Clear DB
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
