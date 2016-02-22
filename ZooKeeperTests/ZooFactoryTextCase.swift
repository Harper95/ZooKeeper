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
        if let zoo = ZooFactory.zooFromJsonFileNamed("zoo") {
            XCTAssert(zoo.staff.count != 0 && zoo.animals.count != 0, "zoo should hace items")
        } else {
            XCTFail("should have zoo")
        }
    }
	
	func test_saveZoo_works() {
		if let zoo = ZooFactory.zooFromJsonFileNamed("zoo") {
			let saved = ZooFactory.saveZoo(zoo, toFileNamed: "zoo2")
			XCTAssert(saved, "should have saved zoo")
		} else {
			XCTFail("should have staff in zoo")
		}
	}
	
	func test_loadSavedZoo_hasNewStuff() {
		if let zoo = ZooFactory.zooFromJsonFileNamed("zoo") {
			zoo.animals.append(Duck(name: "name", color: "color", isMale: true))
			let saved = ZooFactory.saveZoo(zoo, toFileNamed: "zoo2")
			XCTAssert(saved, "should have saved zoo")
			
			if let zoo2 = ZooFactory.zooFromJsonFileNamed("zoo2") {
				XCTAssert(zoo.animals.count == zoo2.animals.count, "new zoo should have new animal")
			} else {
				XCTFail("new zoo should have loaded")
			}
		} else {
			XCTFail("should have staff in zoo")
		}
	}
	
}
