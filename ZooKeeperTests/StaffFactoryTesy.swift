//
//  StaffFactoryTesy.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import XCTest
@testable import ZooKeeper

class StaffFactoryTest: XCTestCase {

    func test_ParseValidJSONFile_CreatesAnimalArray() {
        if let zoo = StaffFactory.zooFromJSONFileNamed("zoo"){
            XCTAssertGreaterThan(zoo.count, 0, "zoo should have items")
        } else {
            XCTFail("should have zoo")
        }
    }
}
