//
//  StaffTest.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import XCTest
@testable import ZooKeeper

class StaffTest: XCTestCase {
    
    func test_reportFunction_works() {
        let staff = Staff(type: "nothing", name: "test", isMale: false)
        XCTAssertGreaterThan(staff.report().characters.count, 0, "Animal report should not be empty")
    }

}
