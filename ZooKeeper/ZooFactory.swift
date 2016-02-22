//
//  ZooFactory.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/18/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZooFactory {
	public static func zooFromJsonFileNamed(name: String) -> Zoo? {
		// Check to see if we have one in the docs dir
		var storePath: String!
		
		if let path = pathToExistingFileInDocumentsDirectory(name + ".json") {
			print("loaded from docs dir")
			storePath = path
		} else if let path = NSBundle.mainBundle().pathForResource(name, ofType: "json") {
			print("loaded from bundle")
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
        
        switch type {
        case "ZooKeeper":
            return ZooKeeper(name: name, isMale: isMale)
        case "TicketTaker":
            return TicketTaker(name: name, isMale: isMale)
        default:
            return nil
        }
    }
    
    public static func animalFromJSON(json: JSON) -> Animal? {
        
        let name: String = json["name"].stringValue
        let color: String = json["color"].stringValue
        let type: String = json["type"].stringValue
        let isMale: Bool = json["isMale"].boolValue
        
        switch type {
        case "Duck":
            return Duck(name: name, color: color, isMale: isMale)
        case "Fish":
            return Fish(name: name, color: color, isMale: isMale)
        case "Bear":
            return Bear(name: name, color: color, isMale: isMale)
        case "Lion":
            return Lion(name: name, color: color, isMale: isMale)
        case "Seal":
            return Seal(name: name, color: color, isMale: isMale)
        default:
            return nil
        }
    }
	
	public static func saveZoo(zoo: Zoo, toFileNamed name: String) -> Bool {
		let path = pathToFileInDocumentsDirectory(name + ".json")
		
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