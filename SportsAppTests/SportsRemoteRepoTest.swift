//
//  SportsRemoteRepoTest.swift
//  SportsAppTests
//
//  Created by ahmedpro on 4/30/20.
//  Copyright © 2020 ahmedpro. All rights reserved.
//

import XCTest
@testable import SportsApp

class SportsRemoteRepoTest: XCTestCase {
    
    var sportsRemoteRepo = SportsRemoteRepo()
    var mockSports = MockSportsRemoteRepo(shouldSportsBeNil: false)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSportsRemoteRepo() {
        var myExpectation = expectation(description: "waiting")
        sportsRemoteRepo.fetchSports(apiURL: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php") {
            sports in
            if let validSports = sports {
                XCTAssertEqual(validSports.count, 20, "didn't match api")
                myExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMockSports() {
        mockSports.fetchSports {
            sports in
            if let validSports = sports {
                XCTAssertEqual(validSports.count, 2, "mock sports count didn't match")
            } else {
                XCTFail()
            }
        }
    }

}
