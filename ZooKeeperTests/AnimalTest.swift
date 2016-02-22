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
	
	func test_savingImage_updateHasImage() {
		//This is an example of a functioanl test case
		let image = UIImage(named: "camera")
		XCTAssertNotNil(image, "need an image")
		
		let animal = Duck(name: "Pete", color: "Blue", isMale: true)
		XCTAssert(animal.saveImage(image!), "saving should return true")
		XCTAssert(animal.hasImage(), "animal should have image")
		
		let loadedImage = animal.loadImage()
		XCTAssertNotNil(loadedImage, "animal image should load off disk")
	}
	
	
}
