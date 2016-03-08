//
//  ZooFactory.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

public class ZooFactory {
	public static func zooFromJsonFileNamed(name: String) -> Zoo? {
		// Check to see if we have one in the docs dir
		var storePath: String!
		
		if let path = CTHPathToExistingFileInDocumentsDirectory(name + ".json") {
			storePath = path
		} else if let path = NSBundle.mainBundle().pathForResource(name, ofType: "json") {
			storePath = path
		} else {
			return nil
		}
		
		if let contentData = NSFileManager.defaultManager().contentsAtPath(storePath) {
                
                let json = JSON(data: contentData)
                let zoo = Zoo(animals: nil, staff: nil)
                
                if let animals = json["animals"].array {
                    for ii in animals {
						
                        if let object = animalFromJSON(ii) {
                            zoo.animals.append(object)
                        }
                    }
                }
                if let staff = json["staff"].array {
                    for ii in staff {
                        if let object = staffFromJSON(ii) {
                            zoo.staff.append(object)
                        }
                    }
                }
                return zoo
        }
        return nil
    }
    
    public static func staffFromJSON(json: JSON) -> Staff? {
        
        let name: String = json["name"].stringValue
        let type: String = json["type"].stringValue
        let isMale: Bool = json["isMale"].boolValue
		var staff: Staff?
        
        switch type {
        case "ZooKeeper":
            staff = ZooKeeper(name: name, isMale: isMale)
        case "TicketTaker":
            staff = TicketTaker(name: name, isMale: isMale)
        default:
            return nil
        }
		
		let photoPath: String = json["imageBase64String"].stringValue
		if !photoPath.isEmpty {
			staff?.imageBase64String = photoPath
		}
		
		let currentWeight: Float = json["currentWeight"].floatValue
		if currentWeight > 0 {
			staff?.currentWeight = currentWeight
		}
		
		if let birthdayString = json["birthday"].string where !birthdayString.isEmpty {
			staff?.birthday = Staff.dateFromString(birthdayString)
		}
		
		return staff
    }
    
    public static func animalFromJSON(json: JSON) -> Animal? {
        
        let name: String = json["name"].stringValue
        let color: String = json["color"].stringValue
        let type: String = json["type"].stringValue
        let isMale: Bool = json["isMale"].boolValue
		var animal: Animal?
		
		switch type {
        case "Duck":
			animal = Duck(name: name, color: color, isMale: isMale)
        case "Fish":
            animal = Fish(name: name, color: color, isMale: isMale)
        case "Bear":
            animal = Bear(name: name, color: color, isMale: isMale)
        case "Lion":
            animal = Lion(name: name, color: color, isMale: isMale)
        case "Seal":
            animal = Seal(name: name, color: color, isMale: isMale)
        default:
            return nil
        }
		
		let photoPath: String = json["imageBase64String"].stringValue
		if !photoPath.isEmpty {
			animal?.imageBase64String = photoPath
		}
		
		let currentWeight: Float = json["currentWeight"].floatValue
		if currentWeight > 0 {
			animal?.currentWeight = currentWeight
		}
		
		if let birthdayString = json["birthday"].string where !birthdayString.isEmpty {
			animal?.birthday = Animal.dateFromString(birthdayString)
		}
		
		return animal
    }
	
	public static func saveZoo(zoo: Zoo, toFileNamed name: String) -> Bool {
		let path = CTHPathToFileInDocumentsDirectory(name + ".json")
		let json = JSON(zoo.toDictionary())
		let str = json.description
		
		do {
			try str.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
		}
		catch (let error) {
			print(error)
			return false
		}
		return true
	}
}

// MARK - Firebase Helpers

extension ZooFactory {
	
	public static func pushZooToFirebase(rootRef: Firebase, zoo: Zoo) {
		
		let animalsListRef = rootRef.childByAppendingPath("animals")
		let staffListRef = rootRef.childByAppendingPath("staff")
		
		for animal in zoo.animals {
			let animalRef = animalsListRef.childByAutoId()
			animalRef.setValue(animal.toDictionary())
		}
		
		for staff in zoo.staff {
			let staffRef = staffListRef.childByAutoId()
			staffRef.setValue(staff.toDictionary())
		}
	}
	
}
