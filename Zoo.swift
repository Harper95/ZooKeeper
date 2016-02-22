//
//  Zoo.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation

public class Zoo {
    public var animals: [Animal]
    public var staff: [Staff]

    public init(animals: [Animal]?, staff: [Staff]?){
        self.animals = animals ?? [Animal]()
        self.staff = staff ?? [Staff]()
    }
	
	public func toDictionary() -> [String: AnyObject] {
		var animalArray = [[String: AnyObject]]()
		var staffArray = [[String: AnyObject]]()
		
		for animal in animals {
			animalArray.append(animal.toDictionary())
		}
		
		for person in staff {
			staffArray.append(person.toDictionary())
		}
		
		return ["animals": animalArray, "staff": staffArray]
	}
}