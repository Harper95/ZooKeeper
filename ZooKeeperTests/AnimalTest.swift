//
//  AnimalTest.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/10/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import XCTest
@testable import ZooKeeper

class AnimalTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_reportFunction_works() {
        let animal = Animal(type: "nothing", name: "test", color: "test", isMale: false)
        XCTAssertGreaterThan(animal.report().characters.count, 0, "Animal report should not be empty")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
