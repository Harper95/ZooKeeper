//
//  ZooFactoryTextCase.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import XCTest
@testable import ZooKeeper

class ZooFactoryTextCase: XCTestCase {
    
    func test_ParseValidJSONFile_CreatesZooObject() {
        if let zoo = ZooFactory.zooFromJsonFileNamed("zoo"){
            XCTAssert(zoo.staff.count != 0 && zoo.animals.count != 0, "zoo should hace items")
        } else {
            XCTFail("should have zoo")
        }
    }
    
}
