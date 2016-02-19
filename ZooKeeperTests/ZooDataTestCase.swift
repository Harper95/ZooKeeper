//
//  ZooDataTestCase.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import XCTest
@testable import ZooKeeper

class ZooDataTestCase: XCTestCase {
    
    func test_singleton_worksAndHasZoo() {
        let zoo = ZooData.sharedInstance.zoo
        XCTAssert(zoo.staff.count > 0, "zoo should have staff")
        XCTAssert(zoo.animals.count > 0, "zoo should have animals")
    }
    
    func test_singleton_isSameInstance() {
        let zoo = ZooData.sharedInstance.zoo
        let zoo2 = ZooData.sharedInstance.zoo
        XCTAssert(zoo === zoo2, "singleton should always return the same instances")
    }
}
