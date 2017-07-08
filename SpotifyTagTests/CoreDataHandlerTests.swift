//
//  SpotifyTagTests.swift
//  SpotifyTagTests
//
//  Created by Guilherme Carvalho on 07/07/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import XCTest
import Sync
@testable import SpotifyTag

class CoreDataHandlerTests: XCTestCase {
    
    var stack:DataStack!
    var dataHandler:CoreDataHandler!
    
    override func setUp() {
        super.setUp()
        
        self.stack = DataStack(modelName: "SpotifyTag", bundle: Bundle.main, storeType: .inMemory)
        self.dataHandler = CoreDataHandler(dataStack: stack)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.stack.mainContext = stack.newNonMergingBackgroundContext()
    }
    
    func testSave(){
        dataHandler.replaceEntities(json: [ProfileMock().getProfileJSON()], name: "Profile") {data in
            let profile = data?.first as? Profile
            XCTAssertNotNil(profile)
            XCTAssert(profile?.id == ProfileMock().getProfileJSON()["id"] as? String)
        }
    }
    
    func testRead(){
        var profiles = dataHandler.getEntity(entity: "Profile") as? [Profile]
        XCTAssertEqual(profiles?.count, 0)
        dataHandler.replaceEntities(json: [ProfileMock().getProfileJSON()], name: "Profile")
        profiles = dataHandler.getEntity(entity: "Profile") as? [Profile]
        XCTAssertEqual(profiles?.count, 1)
        XCTAssert(profiles?.first?.id == ProfileMock().getProfileJSON()["id"] as? String)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
