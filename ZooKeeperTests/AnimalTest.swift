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
    
    func test_reportFunction_works() {
        let animal = Animal(type: "nothing", name: "test", color: "test", isMale: false)
        XCTAssertGreaterThan(animal.report().characters.count, 0, "Animal report should not be empty")
    }
    
}
